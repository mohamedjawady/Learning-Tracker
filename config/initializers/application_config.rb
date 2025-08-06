# Application Configuration for Learning Tracker
# This file contains production-ready configurations

Rails.application.configure do
  # Performance configurations
  config.cache_store = :memory_store, { size: 64.megabytes }
  
  # Security configurations
  config.force_ssl = Rails.env.production?
  
  # Session configurations
  config.session_store :cookie_store, 
    key: '_learning_tracker_session',
    secure: Rails.env.production?,
    httponly: true,
    expire_after: 2.weeks
end

# Application constants
module ApplicationConfig
  APP_NAME = "Learning Tracker"
  VERSION = "1.0.0"
  
  # Pagination
  DEFAULT_PER_PAGE = 10
  MAX_PER_PAGE = 100
  
  # File uploads
  MAX_FILE_SIZE = 10.megabytes
  ALLOWED_FILE_TYPES = %w[pdf txt doc docx].freeze
  
  # Rate limiting
  MAX_REQUESTS_PER_MINUTE = 60
  MAX_LOGIN_ATTEMPTS = 5
  LOCKOUT_DURATION = 15.minutes
  
  # Feature flags
  FEATURES = {
    pdf_upload: true,
    email_notifications: false,
    social_sharing: false,
    advanced_analytics: false
  }.freeze
  
  def self.feature_enabled?(feature)
    FEATURES[feature] || false
  end
end
