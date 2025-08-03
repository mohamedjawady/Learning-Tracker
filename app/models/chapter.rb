class Chapter < ApplicationRecord
  belongs_to :course, optional: true
  belongs_to :book, optional: true

  validates :title, presence: true
  validates :order_number, presence: true, uniqueness: { scope: [:course_id, :book_id] }

  scope :ordered, -> { order(:order_number) }

  def parent
    course || book
  end

  def mark_completed!
    update!(completed: true, completed_at: Time.current)
    parent&.update_status_based_on_progress
  end

  def mark_incomplete!
    update!(completed: false, completed_at: nil)
    parent&.update_status_based_on_progress
  end
end
