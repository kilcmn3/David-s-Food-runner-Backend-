require "http"

API_KEY = ENV["YELP_API_KEY"]

API_HOST = "https://api.yelp.com"
SEARCH_PATH = "/v3/businesses/search"

DEFAULT_TERM = "dinner"
DEFAULT_LOCATION = "New York"
SEARCH_LIMIT = 20

class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :comments, through: :users
  has_many_attached :image
  
  def self.fetch_restaurants(params)
    location = DEFAULT_LOCATION
    if params[:q] 
      term = params[:q]
    end  
      url = "#{API_HOST}#{SEARCH_PATH}"
      params = {
        term: term,
        location: location,
        limit: SEARCH_LIMIT
      }
      response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
      datas = response.parse["business"]
      self.save_database(datas)
      return datas
  end

  def self.save_database(restaurants)
    restaurants.each do |restaurant|
      Restaurant.find_or_create_by(name: restaurant[:name])
    end
  end
  
end
