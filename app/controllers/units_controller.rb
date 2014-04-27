class UnitsController < ApplicationController
  include Tire::Model::Search
  def index
      @units = Unit.page(params[:page]).per(Unit::DEFAULT_SEARCH_SIZE)
  end

  def show
    @unit = Unit.find(params[:id])
  end

  def search
    redirect_to "/" and return unless params[:search].present? && params[:search][:q].present?

    search = Unit.simple_search(params[:search][:q], page: params[:page], facets: false)
    @units = search.results

    render 'index'
  end

  def advanced_search
    params[:search] ||={}
    @show_advanced = true


    search_size = params[:map_view] == "1" ? 500 : 25
    search = Unit.advanced_search(params[:search], search_size, page: params[:page])

    @units = search.results

    if params[:map_view]
      render 'map_view'
    else
      render 'index'
    end
  end

end
