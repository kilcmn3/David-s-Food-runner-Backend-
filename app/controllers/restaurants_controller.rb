class RestaurantsController < ApplicationController
    def index
        restaurants = Restaurant.all
        render json: restaurants  
    end

    def search
        datas = Restaurant.fetch_restaurants(params[:q])
        render json: datas
    end
end
