class UsersController < ApplicationController
    def create
        user = User.find_by(email: params["users"]["email"])
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

    private

    def params_users
        params.require(:users).permit(:email , :password )
    end
end
