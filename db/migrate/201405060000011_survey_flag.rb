class SurveyFlag < ActiveRecord::Migration

  #adding timestamps (updated_at, created_at) to table units
  def change
    add_column :users, :survey_completed, :boolean, :default => FALSE
  end
end
