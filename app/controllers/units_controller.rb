class UnitsController < ApplicationController
  include Tire::Model::Search
  include Yelp::V1::Review::Request
  def index
    params[:search] ||={}

    search_size = params[:map_view] == "1" ? 500 : 25
    search = Unit.advanced_search(params[:search], search_size, page: params[:page])

    @units = search.results

    if params[:map_view]
      render 'map_view'
    else
      render 'index'
    end
  end

  def show
    @unit = Unit.find(params[:id])
    client = Yelp::Client.new


    request = GeoPoint.new(
        :latitude => 37.782093,
        :longitude => -122.483230)
    response = client.search(request)
    puts response
  end

  def search
    redirect_to "/" and return unless params[:search].present? && params[:search][:q].present?

    search = Unit.simple_search(params[:search][:q], page: params[:page], facets: false)
    @units = search.results

    render 'index'
  end
end
