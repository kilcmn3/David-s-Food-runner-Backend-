class RestaurantsController < ApplicationController
    def index
        restaurants = Restaurant.fetch_restaurants(params[:q])
        render json: restaurants
    end
    
    def show
        restaurant = Restaurant.find_by(id: params[:id])
        if restaurant.comments
        render json: restaurant, include: :comments
        elsif !restaurant.comments
            render json: restaurant
        end
    end
    
    def search
        datas = Restaurant.fetch_restaurants(params[:q])
        render json: datas
    end
end
