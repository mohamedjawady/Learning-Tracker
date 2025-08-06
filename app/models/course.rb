class Course < ApplicationRecord
  include Searchable
  include Analytics
  
  belongs_to :user
  has_many :chapters, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :labs, dependent: :destroy
  has_many :calendar_events, as: :eventable, dependent: :destroy
  has_many :notes, as: :notable, dependent: :destroy

  # Enhanced validations
  validates :title, presence: true, length: { minimum: 3, maximum: 200 }
  validates :description, length: { maximum: 1000 }
  validates :instructor, length: { maximum: 100 }
  validates :platform, length: { maximum: 50 }
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp(['http', 'https']), message: "must be a valid URL" }, allow_blank: true
  validates :status, inclusion: { in: %w[not_started in_progress completed paused] }
  validates :total_duration_hours, numericality: { greater_than: 0, less_than_or_equal_to: 1000 }, allow_blank: true
  validates :difficulty_level, inclusion: { in: %w[Beginner Intermediate Advanced Expert] }, allow_blank: true
  validates :start_date, :target_completion_date, presence: true, if: :in_progress?
  
  # Custom validations
  validate :target_completion_date_after_start_date
  validate :sanitize_inputs

  enum status: { not_started: 0, in_progress: 1, completed: 2, paused: 3 }

  def progress_percentage
    return 0 if total_items == 0
    (completed_items.to_f / total_items * 100).round(1)
  end

  def total_items
    chapters.count + videos.count + labs.count
  end

  def completed_items
    chapters.where(completed: true).count + 
    videos.where(completed: true).count + 
    labs.where(completed: true).count
  end

  def next_item
    chapters.where(completed: false).first ||
    videos.where(completed: false).first ||
    labs.where(completed: false).first
  end

  def update_status_based_on_progress
    if progress_percentage == 100
      update(status: :completed)
    elsif progress_percentage > 0
      update(status: :in_progress)
    end
  end

  private

  def target_completion_date_after_start_date
    return unless start_date && target_completion_date
    
    if target_completion_date < start_date
      errors.add(:target_completion_date, "must be after start date")
    end
  end

  def sanitize_inputs
    self.title = title&.strip
    self.description = description&.strip
    self.instructor = instructor&.strip
    self.platform = platform&.strip
  end
end
