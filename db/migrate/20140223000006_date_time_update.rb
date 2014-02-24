class DateTimeUpdate < ActiveRecord::Migration

  #changing avail dat eto datetime from date
  def change
    change_table(:units) do |t|
      t.change :availability_date, :datetime
    end
  end

end
