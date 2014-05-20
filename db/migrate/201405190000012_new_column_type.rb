class NewColumnType < ActiveRecord::Migration

  #adding timestamps (updated_at, created_at) to table units
  def change
    change_column :users, :smoker_accepted, :string, :default => "No"
    change_column :users, :pets_accepted, :string, :default => "No"
    change_column :users, :bed_before_11pm_accepted,:string, :default => "No"
    change_column :users, :wake_before_9am_accepted, :string, :default => "No"
    change_column :users, :music_often_accepted, :string, :default => "No"
    change_column :users, :visitors_often_accepted, :string, :default => "No"
    change_column :users, :social_accepted, :string, :default => "No"
  end
end
