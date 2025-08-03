class Lab < ApplicationRecord
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
end
