class AuthController < ApplicationController
  skip_before_action :require_login
  
  def index
    # Clear invalid session if user doesn't exist
    if session[:user_id] && !User.exists?(session[:user_id])
      log_out
    end
    
    redirect_to root_path if logged_in?
  end
end
