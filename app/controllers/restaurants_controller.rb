require "http"

API_KEY = ENV["YELP_API_KEY"]

API_HOST = "https://api.yelp.com"
SEARCH_PATH = "/v3/businesses/search"

DEFAULT_TERM = "dinner"
DEFAULT_LOCATION = "New York"
SEARCH_LIMIT = 20

class RestaurantsController < ApplicationController
    def index
        restaurants = Restaurant.all
        render json: restaurants  
    end

    def search(location = DEFAULT_LOCATION)
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
        response.parse["business"]
        render json: response.parse["business"]
        ##TODO: when user write a comment ,save restaurant, and comment , to database 
      end
 
end
