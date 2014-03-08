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

    search = Unit.advanced_search(params[:search], page: params[:page])
    @units = search.results

    render 'index'
  end

end
