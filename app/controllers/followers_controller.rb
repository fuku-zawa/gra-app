class FollowersController < ApplicationController
  # フォロワーの一覧を表示する

  def index
    @user = User.find(params[:account_id])

    # 配列
    @followers_list = @user.followers
    @followers = @followers_list.map { |follower| {name: follower.name, avatar: follower.avatar} }
 
  end

end