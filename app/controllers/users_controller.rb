class UsersController < ApplicationController
    def after_sign_in_path_for(resource)
        redirect_to root
    end
    
    def show
        @post = Post.find(params[:id])
        @user = User.find(params[:id])
    end
    
    def show_ather
        @ather_user = User.find(params[:id])
        pp @ather_user
    end
    
    def index
        @user = User.find(params[:id])
        @users = @user.following
    end
    
    def following
        #@userがフォローしているユーザー
        @user = User.find(params[:id])
        @users = @user.following
    end
    
    def followers
        #@userがフォローされているユーザー
        @user = User.find(params[:id])
        @users = @user.followers
    end
end
