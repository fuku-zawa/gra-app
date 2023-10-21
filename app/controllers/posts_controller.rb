class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]

  def index
    @user = current_user&.name || "No Sign"
    @posts = Post.all
    @last = Post.last
    @last_photo = @last.photos
  end

  def new
    @post = current_user.posts.build
    @list 
  end

  def create
    @post = current_user.posts.build(post_params)
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