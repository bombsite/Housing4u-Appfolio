class HomeController < ApplicationController

  def index
    @units = Unit.page(params[:page]).per(10)
  end

end
