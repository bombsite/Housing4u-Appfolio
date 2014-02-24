require "#{Rails.root}/app/helpers/import_helper.rb"
include ImportHelper

namespace :housing4u do

  desc 'runs an importer on /lib/assets/mits.xml'
  task :appfolio_import => :environment do

    unless File.exist?("#{Rails.root}/lib/assets/mits.xml")
      fail 'Make sure the mits.xml file is in the assets dir.'
    end

    #ensure mits file exists
    doc = Nokogiri::XML(File.open("#{Rails.root}/lib/assets/mits.xml"))

    #loop through each rental add
    doc.xpath('//adlist/rentalad').each do |i|

      #find or create user from the xpath
      @user = ImportHelper.find_or_create_user(i.xpath('requiredinfo/username').text,
                                               i.xpath('contactinfo/contactcompany').text,
                                               i.xpath('contactinfo/contactphone1').text)
      break unless @user

      #find the state (if not, create)
      @state = State.find_or_create_by(name: i.xpath('unitinfo/propertystate').text)

      break unless @state

      #find the city (using state id foreign key)
      @city = City.find_or_create_by(name: i.xpath('unitinfo/propertycity').text,
                                     state_id: @state.id)

      break unless @city

      #fetch number of bedrooms
      @bedrooms = ImportHelper.find_number_of_bedrooms(i)

      #fetch number of bathrooms
      @bathrooms = ImportHelper.find_number_of_bathrooms(i)

      #generate availability date
      @avail_date = Date.strptime(i.xpath('unitinfo/propertyavailabilitydate').text,"%m-%d-%Y").to_time rescue nil

      #puts @avail_date
      #break

      #create unit
      @unit = Unit.new( user_id: @user.id,
                        appfolio_reference_id: i.xpath('metainfo/customeradreference').text,
                        appfolio_category: i.xpath('requiredinfo/category').text,
                        allow_email_contact: i.xpath('metainfo/optionallowemailcontact').text.to_i == 1,
                        show_address: i.xpath('metainfo/optionshowaddress').text.to_i == 1,
                        show_map: i.xpath('metainfo/optionshowmap').text.to_i == 1,
                        multi_unit: i.xpath('metainfo/multiunit').text.to_i == 1,
                        ad_headline: i.xpath('requiredinfo/adheadline').text,
                        ad_content: i.xpath('requiredinfo/adcontent').text,
                        property_address: i.xpath('requiredinfo/propertyaddress').text,
                        property_postal_code:  i.xpath('requiredinfo/propertypostalcode').text,
                        tour_video: i.xpath('miscinfo/advirtualtoururl').text,
                        city_id: @city.id,
                        state_id: @state.id,
                        rent_max: i.xpath('unitinfo/propertyrentmax').text,
                        square_foot_min: i.xpath('unitinfo/propertysquarefootmin').text,
                        bedrooms: @bedrooms,
                        bathrooms: @bathrooms,
                        deposit_max: i.xpath('unitinfo/propertydepositmax').text,
                        availability_date: @avail_date,
                        lease_application_fee: i.xpath('leaseinfo/leaseapplicationfee').text,
                        amenities: i.xpath('features/amenityothername1').text,
                        active: i.xpath('metainfo/adactive').text.to_i == 1)
      @unit.save


      #save images
      @counter = 0
      @image_url
      i.xpath('imageinfo/*').each do |f|

        if @counter == 0
          @image_url = f.text
          @counter+=1
        elsif @counter == 1
          UnitPhoto.new(
              unit_id: @unit.id,
              image_url: @image_url,
              image_caption: f.text
          ).save
          @counter = 0
        end

      end

    end

    puts 'Import completed'

  end
end


