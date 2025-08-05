class Course < ApplicationRecord
  has_many :chapters, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :labs, dependent: :destroy
  has_many :calendar_events, as: :eventable, dependent: :destroy
  has_many :notes, as: :notable, dependent: :destroy

  validates :title, presence: true
  validates :status, inclusion: { in: %w[not_started in_progress completed paused] }

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
end
