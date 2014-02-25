class HomeController < ApplicationController

  def index
    @units = Unit.first(50)
    @unit_photos = UnitPhoto.first(1000)
    @cities = City.first(1000)

  end

end
