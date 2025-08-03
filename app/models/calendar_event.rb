class CalendarEvent < ApplicationRecord
  belongs_to :eventable, polymorphic: true, optional: true

  validates :title, presence: true
  validates :start_date, presence: true
  validates :event_type, inclusion: { in: %w[study_session deadline reminder todo] }

  enum event_type: { study_session: 0, deadline: 1, reminder: 2, todo: 3 }

  scope :today, -> { where(start_date: Date.current.beginning_of_day..Date.current.end_of_day) }
  scope :upcoming, -> { where('start_date > ?', Time.current) }
  scope :this_week, -> { where(start_date: Date.current.beginning_of_week..Date.current.end_of_week) }

  def color_class
    case event_type
    when 'study_session'
      'bg-blue-500'
    when 'deadline'
      'bg-red-500'
    when 'reminder'
      'bg-yellow-500'
    when 'todo'
      'bg-green-500'
    else
      'bg-gray-500'
    end
  end

  def to_calendar_json
    {
      id: id,
      title: title,
      start: start_date.iso8601,
      end: end_date&.iso8601,
      color: color_class.gsub('bg-', '#').gsub('-500', ''),
      allDay: all_day
    }
  end
end
