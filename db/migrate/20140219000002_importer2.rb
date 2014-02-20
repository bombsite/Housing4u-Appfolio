class Importer2 < ActiveRecord::Migration
  def change

    #states
    create_table(:states) do |s|
      s.string :name
    end

    #cities
    create_table(:cities) do |c|
      c.string :name
      c.integer    :state_id
      c.foreign_key :states
    end

  end
end
