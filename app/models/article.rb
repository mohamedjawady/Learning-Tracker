class Article < ApplicationRecord
  include Searchable
  include Analytics
  
  belongs_to :user
  has_many :calendar_events, as: :eventable, dependent: :destroy
  has_many :notes, as: :notable, dependent: :destroy

  # Enhanced validations
  validates :title, presence: true, length: { minimum: 3, maximum: 200 }
  validates :url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(['http', 'https']), message: "must be a valid URL" }
  validates :description, length: { maximum: 1000 }
  validates :author, length: { maximum: 100 }
  validates :status, inclusion: { in: %w[not_started in_progress completed paused] }
  validates :publication_date, presence: true, if: :publication_date?
  
  # Custom validations
  validate :publication_date_not_in_future
  validate :sanitize_inputs

  enum status: { not_started: 0, in_progress: 1, completed: 2, paused: 3 }

  def progress_percentage
    return 0 if estimated_read_time == 0 || estimated_read_time.nil?
    return 0 if time_spent == 0 || time_spent.nil?
    percentage = (time_spent.to_f / estimated_read_time * 100).round(1)
    [percentage, 100].min
  end
  
  private
  
  def publication_date_not_in_future
    return unless publication_date && publication_date > Date.current
    
    errors.add(:publication_date, "cannot be in the future")
  end
  
  def sanitize_inputs
    self.title = title&.strip
    self.description = description&.strip
    self.author = author&.strip
    self.url = url&.strip
  end
end
