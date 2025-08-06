class Book < ApplicationRecord
  include Searchable
  include Analytics
  
  belongs_to :user
  has_many :chapters, dependent: :destroy
  has_many :calendar_events, as: :eventable, dependent: :destroy
  has_many :notes, as: :notable, dependent: :destroy

  # Enhanced validations
  validates :title, presence: true, length: { minimum: 3, maximum: 200 }
  validates :author, presence: true, length: { minimum: 2, maximum: 100 }
  validates :description, length: { maximum: 1000 }
  validates :isbn, format: { with: /\A[\d\-X]{10,17}\z/, message: "must be a valid ISBN" }, allow_blank: true
  validates :status, inclusion: { in: %w[not_started in_progress completed paused] }
  validates :total_pages, numericality: { greater_than: 0, less_than_or_equal_to: 10000 }, allow_blank: true
  validates :current_page, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  validates :genre, length: { maximum: 50 }
  validates :publication_year, numericality: { 
    greater_than: 1000, 
    less_than_or_equal_to: Date.current.year + 5 
  }, allow_blank: true
  
  # Custom validations
  validate :current_page_not_greater_than_total
  validate :sanitize_inputs

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

  private

  def current_page_not_greater_than_total
    return unless current_page && total_pages
    
    if current_page > total_pages
      errors.add(:current_page, "cannot be greater than total pages")
    end
  end

  def sanitize_inputs
    self.title = title&.strip
    self.author = author&.strip
    self.description = description&.strip
    self.genre = genre&.strip
    self.isbn = isbn&.strip&.gsub(/\s+/, '')
  end
end
