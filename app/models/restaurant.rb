require "http"
require "json"

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
      datas = self.save_database(response.parse["businesses"])
      return datas
  end

  def self.save_database(restaurants)
    restaurants.each do |restaurant| 
      if !Restaurant.find_by(name: restaurant["name"])
        location = restaurant["location"].to_json
        categories = restaurant["categories"].map{|x| x.to_json}
        Restaurant.create(name: restaurant["name"],location: location, phone: restaurant["phone"] , categories: categories, photos: [restaurant["image_url"]])
      end
    end
    names = restaurants.map{|restaurant| restaurant["name"]}.to_set
    return Restaurant.all.select{|item| names.include?(item.name)}
  end
  
end
