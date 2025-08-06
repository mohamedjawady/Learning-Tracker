class AuthController < ApplicationController
  skip_before_action :require_login
  
  def index
    redirect_to root_path if logged_in?
  end
end
