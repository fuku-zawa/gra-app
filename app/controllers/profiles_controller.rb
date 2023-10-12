class ProfilesController < ApplicationController



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