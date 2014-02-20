class Importer4 < ActiveRecord::Migration
  def change

    #unit photos
    create_table(:unit_photos) do |u|

      u.integer :unit_id, :null =>false
      u.string  :image_url, :null => false
      u.string  :image_caption, :null => true

      u.foreign_key :units

    end

    
  end
end
