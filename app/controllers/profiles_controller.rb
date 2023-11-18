class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile = current_user.prepare_profile
    @user = current_user
    @user_name = current_user.name
    @posts = current_user.posts
    @followers = current_user.followers.length
    @followings = current_user.followings.length

    @list = []
    post_list
  end

  def edit
    @profile = current_user.prepare_profile
    @user = current_user
    @user_name = current_user.name
  end

  def update
    @profile = current_user.prepare_profile
    @profile.assign_attributes(profile_params)
    @user_name = current_user
    
    avatar_change
    
  end

  private 
  def profile_params
    params.require(:profile).permit(
    :introduction,
    :gender,
    :birthday,
    :avatar,
    )
  end

  def user_params
    params[:profile].require(:user).permit(:name)
  end

  def avatar_change
    # editページのprofileをupdate
    if params[:profile][:user].presence
      @user_name.assign_attributes(user_params)
      if @profile.save && @user_name.save
        redirect_to edit_profile_path, notice: "変更しました"
      else
        flash.now[:error] = "変更できませんでした"
        render :edit
      end
    # showページのprofileをupdate
    else
      if @profile.save
        redirect_to profile_path, notice: "変更しました"
      else
        flash.now[:error] = "変更できませんでした"
        render :show
      end
    end
  end

  # ユーザのpostからphotoを取得しリストにする→profiles/showで表示
  def post_list
    @posts.each do |post|
      post.photos.each do |photo|
        @list.append(photo)
      end
    end
  end




end