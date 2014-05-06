class ProfileFields2 < ActiveRecord::Migration

  #adding timestamps (updated_at, created_at) to table units
  def change
    add_column :users, :smoker_accepted, :boolean, :default => FALSE
    add_column :users, :pets_accepted, :boolean, :default => FALSE
    add_column :users, :bed_before_11pm_accepted,:text
    add_column :users, :wake_before_9am_accepted, :text
    add_column :users, :music_often_accepted, :text
    add_column :users, :visitors_often_accepted, :text
    add_column :users, :social_accepted, :text
  end
end
