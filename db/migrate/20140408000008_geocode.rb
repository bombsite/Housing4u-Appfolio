class Geocode < ActiveRecord::Migration

  def change

    add_column :units, :latitude, :float
    add_column :units, :longitude, :float
    add_column :units, :formatted_address, :text

  end

end
