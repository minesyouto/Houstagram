class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  

  def index
    #投稿を新着順で7個
    @posts = Post.order(created_at: :desc).limit(7)
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}")
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    #コメントを新着順で表示するようにする
    @comments = @post.comments.order(created_at: :desc)
    @user = User.find_by(id: @post.user_id)
  end

  def new
    login_check
    @post = Post.new
  end
  
  def login_check
    if current_user.nil?
      redirect_to root_url, alert: "新規投稿するには会員登録、またはログインしてください。"
    end
  end

  def edit
    unless @post.user == current_user
      redirect_to  new_post_path
    end
  end

  def create
    @post = Post.new(post_params.merge(user_id: current_user.id, username: current_user.username))
      if 
        @post.save
        redirect_to @post
      else
        render 'posts/new'
      end
  end
  

  def update
      if @post.update(post_params)
        redirect_to @post, notice: "投稿完了"
      else
        render :edit, status: :unprocessable_entity
      end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: "削除完了" 
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :tag_list, post_images_post_images: [])
    end
    
    
end
