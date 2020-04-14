class CommentsController < ApplicationController

    def create
        comment_saved = nil
        # comment = Comment.find_by(user_id: params[:user_id])
        # restaurant = Restaurant.find_by(id: params[:restaurants_id])
        # user = User.find_by(id: params[:user_id])
        if true
            comment_saved = Comment.create(params_comment)
        else
            comment_saved = Comment.update(params_comment)    
        end

                
        if comment_saved.valid?
            render json: {
                status: 200
            }
        else
            render json: comment_saved.errors.full_messages
        end
    end

    private

    def params_comment
        params.require(:comment).permit(:comment , :user_id , :restaurant_id )
    end
end
