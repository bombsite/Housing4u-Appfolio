require "#{Rails.root}/app/helpers/import_helper.rb"
include ImportHelper

namespace :housing4u do

  desc 'runs an importer on /lib/assets/mits.xml'
  task :appfolio_import => :environment do

    unless File.exist?("#{Rails.root}/lib/assets/mits.xml")
      puts 'Make sure the mits.xml file is in the assets dir.'
      next
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

      #find the city (if not, create)




      #run once!
      break

    end

    puts 'Import completed'

  end
end


