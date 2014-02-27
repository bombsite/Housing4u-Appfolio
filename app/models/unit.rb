class Unit < ActiveRecord::Base
  belongs_to :user
  has_many :UnitPhotos
  belongs_to :city
  belongs_to :state
end
