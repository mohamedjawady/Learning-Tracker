class Article < ApplicationRecord
  has_many :calendar_events, as: :eventable, dependent: :destroy
  has_many :notes, as: :notable, dependent: :destroy

  validates :title, presence: true
  validates :url, presence: true
  validates :status, inclusion: { in: %w[not_started in_progress completed paused] }

  enum status: { not_started: 0, in_progress: 1, completed: 2, paused: 3 }

  def progress_percentage
    return 0 if estimated_read_time == 0 || estimated_read_time.nil?
    return 0 if time_spent == 0 || time_spent.nil?
    percentage = (time_spent.to_f / estimated_read_time * 100).round(1)
    [percentage, 100].min
  end
end
