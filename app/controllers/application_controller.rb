class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def set_current_date
    @current_date = Date.current
  end
end
