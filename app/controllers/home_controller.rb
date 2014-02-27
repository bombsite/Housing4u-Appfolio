class HomeController < ApplicationController

  def index
    @units = Unit.includes(:UnitPhotos, :City, :State).page(params[:page]).per(10)
  end

end
