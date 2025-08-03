class Video < ApplicationRecord
  belongs_to :course

  validates :title, presence: true
  validates :order_number, presence: true, uniqueness: { scope: :course_id }

  scope :ordered, -> { order(:order_number) }

  def mark_completed!
    update!(completed: true, completed_at: Time.current)
    course&.update_status_based_on_progress
  end

  def mark_incomplete!
    update!(completed: false, completed_at: nil)
    course&.update_status_based_on_progress
  end

  def progress_percentage
    return 0 if duration_minutes == 0 || duration_minutes.nil?
    return 0 if watched_minutes == 0 || watched_minutes.nil?
    percentage = (watched_minutes.to_f / duration_minutes * 100).round(1)
    [percentage, 100].min
  end
end
