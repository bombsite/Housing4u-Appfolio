class HomeController < ApplicationController

  def index
    @units = Unit.includes(:UnitPhotos, :City, :State).first(50)
  end

end
