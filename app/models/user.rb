class User < ApplicationRecord
  has_secure_password
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true, length: { minimum: 2 }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  
  # Associations with learning resources
  has_many :courses, dependent: :destroy
  has_many :books, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :todos, dependent: :destroy
  has_many :calendar_events, dependent: :destroy
  has_many :notes, dependent: :destroy
  
  before_save { email.downcase! }
  
  def full_name
    name
  end
  
  def initials
    name.split.map(&:first).join.upcase
  end
end
