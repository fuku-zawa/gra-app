class FollowsController < ApplicationController
  before_action :authenticate_user!

  # フォローしているかの状態を返す
  def index
    account_id = params[:account_id]
    user = User.find(account_id)
    # has_followed?で定義しているので、?まで必要
    follow_status = current_user.has_followed?(user)
    # userのフォロワー数
    follower_count = user.followers.count

    render json: { hasFollowed: follow_status, followers: follower_count}
  end


  def create
    current_user.follow!(params[:account_id])
    render json: { status: 'ok' }
  end


end