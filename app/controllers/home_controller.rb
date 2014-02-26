class HomeController < ApplicationController

  def index
    @units = Unit.includes(:UnitPhotos, :City, :State).first(1000)
    @units = Unit.all.page(params[:page]).per(10)
  end

end
