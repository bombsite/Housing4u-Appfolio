# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#see : http://stackoverflow.com/questions/8342642/how-can-i-import-a-sql-file-into-a-rails-database

#order of below is important due to foreign key constraints
ActiveRecord::Base.connection.execute(IO.read("#{Rails.root}/db/appfolio_seeds/users.sql"))

ActiveRecord::Base.connection.execute(IO.read("#{Rails.root}/db/appfolio_seeds/states.sql"))

ActiveRecord::Base.connection.execute(IO.read("#{Rails.root}/db/appfolio_seeds/cities.sql"))

ActiveRecord::Base.connection.execute(IO.read("#{Rails.root}/db/appfolio_seeds/units.sql"))

ActiveRecord::Base.connection.execute(IO.read("#{Rails.root}/db/appfolio_seeds/unit_photos.sql"))

#update sequences for future inserts
ActiveRecord::Base.connection.execute(IO.read("#{Rails.root}/db/appfolio_seeds/update_sequences.sql"))
