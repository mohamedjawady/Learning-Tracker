class SessionsController < ApplicationController
  skip_before_action :require_login
  
  def new
    redirect_to root_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to root_path, notice: "👋 Welcome back, #{user.name}!"
    else
      flash.now[:alert] = "❌ Invalid email or password. Please try again."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to auth_path, notice: "👋 You have been logged out successfully!"
  end
end
