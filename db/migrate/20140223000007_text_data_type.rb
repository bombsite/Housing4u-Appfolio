class TextDataType < ActiveRecord::Migration

  #changing to text type from varchar
  def change
    change_table(:units) do |t|
      t.change :ad_headline, :text
      t.change :ad_content, :text
      t.change :property_address, :text
      t.change :amenities, :text
      t.change :tour_video, :text
    end
    change_table(:unit_photos) do |t|
      t.change :image_url, :text
      t.change :image_caption, :text
    end
  end

end
