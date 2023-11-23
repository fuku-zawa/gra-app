class AccountsController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])

    @list = []
    post_list
  end


  # ユーザのpostからphotoを取得しリストにする→accounts/showで表示
  def post_list
    @user.posts.each do |post|
      post.photos.each do |photo|
        @list.append(photo)
      end
    end
  end
end