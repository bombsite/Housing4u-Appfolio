

class Unit < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
  belongs_to :user
  has_many :UnitPhotos
  belongs_to :city
  belongs_to :state

  DEFAULT_SEARCH_SIZE = 25

  def self.simple_search(search_terms, options={})
    search = Tire.search Unit.tire.index.name, load:true do
      # What we're looking for
      query do
        string search_terms, fields: [:ad_headline, :ad_content]
      end

      #highlight :ad_headline, :ad_content

      # Sort results
      sort { by :created_at }

      # Results pagination / number of results per page
      page = (options[:page] || 1).to_i
      search_size = options[:per] || DEFAULT_SEARCH_SIZE
      from (page -1) * search_size
      size search_size

      #facets
      facet('current-city') { terms :city_id }
      facet('current-state') { terms :state_id }
      facet('current-bathroom') {terms :bathrooms}
      facet('current-bedroom'){terms :bedrooms}
    end
  end

  def self.advanced_search(search_conditions, options={})
    fields = [:ad_headline, :ad_content, :city_id, :bathrooms, :bedrooms]

    search = Tire.search Unit.tire.index.name, load:true do

      # What we're looking for
      query do
        boolean do
          fields.each do |field|
            must { string search_conditions[field], :default_operator => 'AND', :fields => [field] } if search_conditions[field].present?
          end
        end
      end

      #highlight :ad_headline, :ad_content, :options => { :tag => '<strong class="highlight">' }
      #highlight *fields

      # Sort results
      sort { by :created_at }

      # Results pagination / number of results per page
      page = (options[:page] || 1).to_i
      search_size = options[:per] || DEFAULT_SEARCH_SIZE
      from (page -1) * search_size
      size search_size

      #facets
      facet('current-city') { terms :city_id }
      facet('current-state') { terms :state_id }
      facet('current-bathroom') {terms :bathrooms}
      facet('current-bedroom'){terms :bedrooms}
      end
  end

end
