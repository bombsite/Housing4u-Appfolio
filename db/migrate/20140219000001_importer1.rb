class Importer1 < ActiveRecord::Migration
  def change

    #under contactinfo in mits
    add_column :users, :phone_number, :string, null: true
    add_column :users, :company_name, :string, null: true


   end
end
