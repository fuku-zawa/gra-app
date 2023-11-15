class FollowsController < ApplicationController
  before_action :authenticate_user!

  # フォローしているかの状態を返す
  def index
    account_id = params[:account_id]
    user = User.find(account_id)
    # has_followed?の?が必要
    follow_status = current_user.has_followed?(user)
    
    render json: { hasFollowed: follow_status}
  end

  def create
    current_user.follow!(params[:account_id])
    render json: { status: 'ok' }
  end


end