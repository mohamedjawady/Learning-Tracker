module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  # Alias for compatibility
  alias_method :user_signed_in?, :logged_in?
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  def current_user?(user)
    user == current_user
  end
end
