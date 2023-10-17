class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = current_user&.name || "No Sign"
  end

  def new

  end

end