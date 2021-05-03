class CommentsController < ApplicationController
    def create
        comment = nil
        if !comment
            comment = Comment.create(params_comment)
        else
            comment = Comment.update(params_comment)    
        end
            restaurant = Restaurant.find_by(id: comment.restaurant_id)
            render json: restaurant.comments
    end
    
    def destroy
        comment = Comment.find(params[:id])
        comment.destroy
        render json: {
            status: "delete it"
        }
    end

    private

    def params_comment
 
        params.require(:comment).permit(:comment , :user_id , :restaurant_id, :user_email )
    end
end
