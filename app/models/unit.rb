class Unit < ActiveRecord::Base
  belongs_to :User
  has_many :UnitPhotos
  has_one :State
  has_one :City
end
