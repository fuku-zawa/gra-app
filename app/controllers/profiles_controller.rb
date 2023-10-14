class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile = current_user.profile
    @user_name = current_user.name
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
    @user_name.assign_attributes(user_params)
    if @profile.save && @user_name.save
      redirect_to profile_path, notice: "変更しました"
    else
      flash.now[:error] = "変更できませんでした"
      render :edit
    end
    
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
end