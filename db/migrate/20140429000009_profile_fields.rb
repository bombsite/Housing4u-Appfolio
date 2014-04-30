class ProfileFields < ActiveRecord::Migration

  #adding timestamps (updated_at, created_at) to table units
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :gender, :string
    add_column :users, :smoker, :boolean, :default => FALSE
    add_column :users, :language_spoken, :string
    add_column :users, :pets, :boolean, :default => FALSE
    add_column :users, :bed_before_11pm, :boolean, :default => FALSE
    add_column :users, :wake_before_9am, :boolean, :default => FALSE
    add_column :users, :music_often, :boolean, :default => FALSE
    add_column :users, :visitors_often, :boolean, :default => FALSE
    add_column :users, :social, :boolean, :default => FALSE
  end
end
