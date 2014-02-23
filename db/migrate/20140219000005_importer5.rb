class Importer5 < ActiveRecord::Migration

  #adding timestamps (updated_at, created_at) to table units
  def change
    change_table(:units) { |t| t.timestamps }
  end
end
