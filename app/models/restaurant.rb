require "http"

API_KEY = ENV["YELP_API_KEY"]

API_HOST = "https://api.yelp.com"
SEARCH_PATH = "/v3/businesses/search"

DEFAULT_TERM = "dinner"
DEFAULT_LOCATION = "New York"
SEARCH_LIMIT = 20

class Restaurant < ApplicationRecord
  has_many :comments
  has_many :users, through: :comments
  has_many_attached :image
  
  def self.fetch_restaurants(query)
    location = DEFAULT_LOCATION
    term = DEFAULT_TERM
    if query
      term = query
    end  
      url = "#{API_HOST}#{SEARCH_PATH}"
      params = {
        term: term,
        location: location,
        limit: SEARCH_LIMIT
      }
      response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
      datas = response.parse["businesses"]
      self.save_database(datas)
      return datas
  end

  def self.save_database(restaurants)
  
    restaurants.each do |restaurant| 
      if !Restaurant.find_by(name: restaurant["name"])
        Restaurant.create(name: restaurant["name"],location: restaurant["location"],phone: restaurant["phone"] , categories: restaurant["categories"])
      end
    end
  end
  
end
