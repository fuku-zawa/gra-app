class FollowingsController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = User.find(params[:account_id])

    # 配列
    @followings_list = @user.followings
    @followings = @followings_list.map { |following| {name: following.name, avatar: following.avatar} }
 
  end

end