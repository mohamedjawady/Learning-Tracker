class Todo < ApplicationRecord
  belongs_to :user
  
  # Enhanced validations
  validates :title, presence: true, length: { minimum: 3, maximum: 200 }
  validates :description, length: { maximum: 1000 }
  validates :priority, inclusion: { in: %w[low medium high] }, allow_nil: true
  validates :due_date, presence: true, if: :high_priority?
  
  # Custom validations
  validate :due_date_not_in_past, if: :due_date?
  validate :sanitize_inputs

  enum priority: { low: 0, medium: 1, high: 2 }

  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where(completed: false) }
  scope :by_priority, -> { order(:priority) }
  scope :overdue, -> { where('due_date < ? AND completed = ?', Date.current, false) }
  scope :due_today, -> { where(due_date: Date.current, completed: false) }

  # Callbacks
  before_save :set_completed_at

  def toggle_complete!
    update!(completed: !completed, completed_at: completed? ? nil : Time.current)
  end

  def priority_color
    case priority
    when 'high'
      'text-red-600'
    when 'medium'
      'text-yellow-600'
    when 'low'
      'text-green-600'
    else
      'text-gray-600'
    end
  end

  def high_priority?
    priority == 'high'
  end

  def overdue?
    due_date && due_date < Date.current && !completed?
  end

  private

  def due_date_not_in_past
    return unless due_date && due_date < Date.current
    
    errors.add(:due_date, "cannot be in the past")
  end

  def sanitize_inputs
    self.title = title&.strip
    self.description = description&.strip
  end

  def set_completed_at
    if completed_changed?
      self.completed_at = completed? ? Time.current : nil
    end
  end
end
