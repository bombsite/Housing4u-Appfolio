class Importer3 < ActiveRecord::Migration
  def change

    #units table
    create_table(:units) do |t|

      t.integer :user_id, :null => true
      t.string  :appfolio_reference_id, :null => true #customer ad reference
      t.string  :appfolio_category, :null => true #category in mits file
      t.boolean :allow_email_contact, :null => false, :default => true
      t.boolean :show_address, :null => false, :default => true
      t.boolean :show_map, :null => false, :default => true
      t.boolean :multi_unit, :null => false, :default => false
      t.string  :ad_headline, :null => true
      t.string  :ad_content, :null => true
      t.string  :property_address, :null => true
      t.string  :property_postal_code, :null => true
      t.string  :tour_video, :null => true #refers to miscinfo -> advirtualtoururl

      #defining both in cas euser wants to define state but not city
      t.integer  :city_id, :null => true
      t.integer  :state_id, :null => true

      t.float   :rent_max, :null => true
      t.float   :square_foot_min, :null => true
      t.float   :bedrooms, :null => true
      t.float   :bathrooms, :null => true
      t.float   :deposit_max, :null => true
      t.date    :availability_date, :null => true
      t.float   :lease_application_fee, :null => true
      t.string  :amenities, :null => true

      t.boolean :active, :null => false, :default => true


      t.foreign_key :cities #links to cities (city_id) may not work because of s ->> ies
      t.foreign_key :users
      t.foreign_key :states

    end
    
  end
end
