class CommentsController < ApplicationController
    def create
        @comment = Comment.create(comment_params)
        @comment.save
        render :index
    end
    
    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        render :index
    end
    
    private
        def comment_params
            params.require(:comment).permit(:content, :post_id, :user_id)
        end
end
