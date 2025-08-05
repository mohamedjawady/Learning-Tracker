class Book < ApplicationRecord
  has_many :chapters, dependent: :destroy
  has_many :calendar_events, as: :eventable, dependent: :destroy
  has_many :notes, as: :notable, dependent: :destroy

  validates :title, presence: true
  validates :status, inclusion: { in: %w[not_started in_progress completed paused] }

  enum status: { not_started: 0, in_progress: 1, completed: 2, paused: 3 }

  mount_uploader :pdf_file, PdfFileUploader

  def progress_percentage
    return 0 if total_pages == 0 || total_pages.nil?
    return 0 if current_page == 0 || current_page.nil?
    (current_page.to_f / total_pages * 100).round(1)
  end

  def chapters_progress_percentage
    return 0 if chapters.count == 0
    (chapters.where(completed: true).count.to_f / chapters.count * 100).round(1)
  end

  def next_chapter
    chapters.where(completed: false).first
  end

  def has_pdf?
    pdf_file.present?
  end

  def update_status_based_on_progress
    if progress_percentage == 100
      update(status: :completed)
    elsif progress_percentage > 0
      update(status: :in_progress)
    end
  end
end
