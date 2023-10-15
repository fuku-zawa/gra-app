class HomeController < ApplicationController
  def index
    @user = current_user&.name || "No Sign"
  end
end