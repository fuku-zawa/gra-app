class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all
    @current_user = current_user
  end

  def new
    @post = current_user.posts.build
    @user = current_user
    @list 
  end

  def create
    @post = current_user.posts.build(post_params)
    # 投稿をはじいた時に、@userを取得できるように
    @user = current_user
    
    if @post.save
      redirect_to posts_path, notice: "保存できたよ"
    else
      flash.now[:error] = "保存に失敗しました"
      render :new
    end

  end

  private
  def post_params
    params.require(:post).permit(:mind, photos: [])
  end


end