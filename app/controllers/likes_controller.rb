class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    # ヘルパー：post_like_path　URL：/posts/:post_id/like(.:format)
    # リクエストで送られてくる:post_idをparamsで取得＝いいねしたpostを取得
    post = Post.find(params[:post_id])
    # likesテーブルにはuser_idも必要なので渡して保存する 
    post.likes.create!(user_id: current_user.id)
    redirect_to root_path
  end

end