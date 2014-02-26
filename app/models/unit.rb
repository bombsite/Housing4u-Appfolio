class Unit < ActiveRecord::Base
  belongs_to :User
  has_many :UnitPhotos
  belongs_to :City
  belongs_to :State
end
