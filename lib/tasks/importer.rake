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

    xx = 0

    #loop through each rental add
    doc.xpath('//adlist/rentalad').each do |i|

      xx += 1

      geocode_results = Geocoder.search(i.xpath('requiredinfo/propertyaddress').text + ", " +
                                       i.xpath('unitinfo/propertycity').text + ", " +
                                       i.xpath('unitinfo/propertystate').text + " " +
                                       i.xpath('requiredinfo/propertypostalcode').text
                                      )
      next if geocode_results[0] == nil

      puts xx

      geocode_state = geocode_results[0].state_code
      geocode_city  = geocode_results[0].city
      geocode_postal  = geocode_results[0].postal_code
      geocode_formatted_address = geocode_results[0].address_data["formattedAddress"]
      geocode_latitude = geocode_results[0].coordinates[0]
      geocode_longitude = geocode_results[0].coordinates[1]
      geocode_address_line = geocode_results[0].address_data["addressLine"]

      #puts geocode_state
      #puts geocode_city
      #puts geocode_postal
      #puts geocode_formatted_address
      #puts geocode_latitude
      #puts geocode_longitude
      #puts geocode_address_line

      #find or create user from the xpath
      @user = ImportHelper.find_or_create_user(i.xpath('requiredinfo/username').text,
                                               i.xpath('contactinfo/contactcompany').text,
                                               i.xpath('contactinfo/contactphone1').text)
      break unless @user

      #find the state (if not, create)
      @state = State.find_or_create_by(name: geocode_state)

      break unless @state

      #find the city (using state id foreign key)
      @city = City.find_or_create_by(name: geocode_city,
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
                        ad_headline: i.xpath('requiredinfo/adheadline').text.strip,
                        ad_content: i.xpath('requiredinfo/adcontent').text.strip,
                        property_address: geocode_address_line,
                        property_postal_code:  geocode_postal,
                        tour_video: i.xpath('miscinfo/advirtualtoururl').text.strip,
                        city_id: @city.id,
                        state_id: @state.id,
                        rent_max: i.xpath('unitinfo/propertyrentmax').text.strip,
                        square_foot_min: i.xpath('unitinfo/propertysquarefootmin').text.strip,
                        bedrooms: @bedrooms,
                        bathrooms: @bathrooms,
                        deposit_max: i.xpath('unitinfo/propertydepositmax').text.strip,
                        availability_date: @avail_date,
                        lease_application_fee: i.xpath('leaseinfo/leaseapplicationfee').text.strip,
                        amenities: i.xpath('features/amenityothername1').text.strip,
                        active: (i.xpath('metainfo/adactive').text.to_i == 1),
                        latitude: geocode_latitude,
                        longitude: geocode_longitude,
                        formatted_address: geocode_formatted_address )


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


