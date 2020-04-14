class RestaurantsController < ApplicationController
    def index
        restaurants = Restaurant.all
        render json: restaurants  
    end
    
    def show
        restaurant = Restaurant.find_by(id: params[:id])
        render json: restaurant, include: :comments
    end
    
    def search
        datas = Restaurant.fetch_restaurants(params[:q])
        render json: datas
    end
end
