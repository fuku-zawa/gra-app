class LikesController < ApplicationController
  before_action :authenticate_user!

  def show
    post = Post.find(params[:post_id])
    like_status = current_user.has_liked(post)
    # jsonのレスポンスがlike_status（trueかfalseを返す）
    render json: {hasLiked: like_status}
  end


  def create
    # ヘルパー：post_like_path　URL：/posts/:post_id/like(.:format)
    # リクエストで送られてくる:post_idをparamsで取得＝いいねしたpostを取得
    post = Post.find(params[:post_id])
    # likesテーブルにはuser_idも必要なので渡して保存する 
    post.likes.create!(user_id: current_user.id)
    redirect_to root_path
  end

  def destroy
    post = Post.find(params[:post_id])
    like = post.likes.find_by!(user_id: current_user.id)
    like.destroy!
    redirect_to root_path
  end

end