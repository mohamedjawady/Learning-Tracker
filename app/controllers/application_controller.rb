class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # Authentication helpers
  include SessionsHelper
  
  before_action :require_login
  before_action :set_current_date
  
  # Error handling
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  
  # Rate limiting (basic implementation)
  # before_action :check_rate_limit

  private

  def set_current_date
    @current_date = Date.current
  end
  
  def require_login
    unless logged_in?
      if controller_name == 'dashboard' && action_name == 'index'
        redirect_to auth_path, alert: "🔒 Please log in to access your dashboard."
      else
        redirect_to auth_path, alert: "🔒 Please log in to access this page."
      end
    end
  end
  
  def record_not_found
    redirect_to auth_path, alert: "❌ The requested resource could not be found."
  end
  
  def parameter_missing(exception)
    redirect_to auth_path, alert: "❌ Required information is missing: #{exception.param}"
  end
  
  def record_invalid(exception)
    redirect_to request.referer || auth_path, alert: "❌ #{exception.record.errors.full_messages.join(', ')}"
  end
  
  def check_rate_limit
    return unless logged_in?
    
    key = "rate_limit:#{current_user.id}:#{request.remote_ip}"
    count = Rails.cache.read(key) || 0
    
    if count >= ApplicationConfig::MAX_REQUESTS_PER_MINUTE
      render json: { error: "Rate limit exceeded. Please try again later." }, status: 429
      return
    end
    
    Rails.cache.write(key, count + 1, expires_in: 1.minute)
  end
  
  def ensure_current_user_owns_resource(resource)
    unless resource.user == current_user
      redirect_to auth_path, alert: "❌ You don't have permission to access this resource."
    end
  end
end
