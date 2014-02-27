class HomeController < ApplicationController

  def index
    @units = Unit.includes(:UnitPhotos, :City, :State)
    @units = Unit.all.page(params[:page]).per(10)
  end

end
