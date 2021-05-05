class UsersController < ApplicationController

    def login
        user = User.find_by(email: params["q"])

        if user
            render json: user
        elsif user == nil
            render json: -1           
        end
    end
    
    def show
        user = User.find(params[:id])
        render json: user
    end

    def create
        user =  User.find_by(email: params["users"]["email"])

        if !user
            User.create(params_users)
            render json: {
                status: 200
            }
        elsif 
            render json: {
                errors: user.erros.full_messages
            }
        end
    end

    def update
        user = User.find_by(id: params["q"])
            render json: {
                status:200
            }
    end
    private

    def params_users
        params.require(:users).permit(:email , :password )
    end
end
