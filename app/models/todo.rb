class Todo < ApplicationRecord
  validates :title, presence: true
  validates :priority, inclusion: { in: %w[low medium high] }, allow_nil: true

  enum priority: { low: 0, medium: 1, high: 2 }

  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where(completed: false) }
  scope :by_priority, -> { order(:priority) }

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
end
