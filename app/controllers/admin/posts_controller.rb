class Admin::PostsController < ApplicationController
    before_action :check_admin
    
    def show
        @post =Post.find(params[:id])
    end
    
    def destroy
        @post.destroy
        redirect_to posts_url, notice: "削除完了" 
    end
    
    
    private
    def check_admin
        redirect_to root_path unless current_user.admin?
    end
end
