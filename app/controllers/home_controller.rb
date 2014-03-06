class HomeController < ApplicationController

  def index
    if params[:query].present?
      @units = Unit.search(params[:query], page: params[:page], per_page: 10, fields: [:ad_headline], misspellings: false)
    else
      @units = Unit.all.page params[:page]
    end
  end

end
