# Analytics helper for dashboard metrics
module Analytics
  extend ActiveSupport::Concern
  
  class_methods do
    def completion_stats
      {
        total: count,
        completed: where(status: :completed).count,
        in_progress: where(status: :in_progress).count,
        not_started: where(status: :not_started).count,
        paused: where(status: :paused).count
      }
    end
    
    def progress_over_time(days = 30)
      end_date = Date.current
      start_date = end_date - days.days
      
      (start_date..end_date).map do |date|
        {
          date: date,
          completed: where(status: :completed)
                    .where('updated_at::date = ?', date)
                    .count
        }
      end
    end
    
    def average_completion_time
      completed_items = where(status: :completed)
                       .where.not(created_at: nil, updated_at: nil)
      
      return 0 if completed_items.empty?
      
      total_days = completed_items.sum do |item|
        (item.updated_at.to_date - item.created_at.to_date).to_i
      end
      
      (total_days.to_f / completed_items.count).round(1)
    end
  end
  
  def time_to_complete
    return nil unless completed? && created_at && updated_at
    (updated_at.to_date - created_at.to_date).to_i
  end
end
