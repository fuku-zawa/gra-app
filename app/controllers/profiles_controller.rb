class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user.name
  end


  private 
  def profile_params
    params.require(:profile).permit(
      :introduction,
      :gender,
      :birthday,
      :avatar
    )
  end
end