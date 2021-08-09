class CommentsController < ApplicationController
    def create
        @comment = Comment.create(comment_params)
        @comment.save
        render :index
    end
    
    def destroy
        @post = Post.find(params[:post_id])
        @comment = current_user.comments.find_by(post_id: @post.id)
        @comment.destroy
        render :index
    end
    
    private
        def comment_params
            params.require(:comment).permit(:content).merge(user_id: current_user.id, post_id: params[:post_id])
        end
end
