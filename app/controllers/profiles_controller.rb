class ProfilesController < ApplicationController

  def show
    
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