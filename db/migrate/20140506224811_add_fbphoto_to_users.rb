class AddFbphotoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_photo_url, :string
  end
end
