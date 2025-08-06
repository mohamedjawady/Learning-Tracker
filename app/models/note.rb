class Note < ApplicationRecord
  include Searchable
  
  belongs_to :user
  belongs_to :parent, class_name: 'Note', optional: true
  has_many :children, class_name: 'Note', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :notable, polymorphic: true, optional: true

  # Enhanced validations
  validates :title, presence: true, length: { minimum: 1, maximum: 200 }
  validates :content, length: { maximum: 50000 }
  validates :position, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :color, format: { with: /\A#[0-9a-fA-F]{6}\z/, message: "must be a valid hex color" }
  
  # Custom validations
  validate :parent_belongs_to_same_user
  validate :sanitize_inputs

  scope :root_notes, -> { where(parent_id: nil) }
  scope :folders, -> { where(is_folder: true) }
  scope :notes, -> { where(is_folder: false) }
  scope :ordered, -> { order(:position, :created_at) }

  before_save :set_default_position

  def self.for_resource(resource)
    where(notable: resource)
  end

  def has_children?
    children.any?
  end

  def depth
    parent ? parent.depth + 1 : 0
  end

  def ancestors
    parent ? parent.ancestors + [parent] : []
  end

  def descendants
    children.flat_map { |child| [child] + child.descendants }
  end

  def tag_list
    tags&.split(',')&.map(&:strip) || []
  end

  def tag_list=(new_tags)
    self.tags = Array(new_tags).join(', ')
  end

  def move_to_position(new_position)
    update!(position: new_position)
    reorder_siblings
  end

  def move_to_parent(new_parent)
    update!(parent: new_parent, position: (new_parent&.children&.maximum(:position) || 0) + 1)
  end

  private

  def set_default_position
    return if position.present?
    
    max_position = if parent_id
                    parent.children.maximum(:position) || 0
                  else
                    self.class.root_notes.maximum(:position) || 0
                  end
    self.position = max_position + 1
  end

  def reorder_siblings
    siblings = parent ? parent.children.where.not(id: id) : self.class.root_notes.where.not(id: id)
    siblings.order(:position).each_with_index do |sibling, index|
      new_pos = index >= position ? index + 1 : index
      sibling.update_column(:position, new_pos) if sibling.position != new_pos
    end
  end
  
  private
  
  def parent_belongs_to_same_user
    return unless parent && parent.user != user
    
    errors.add(:parent, "must belong to the same user")
  end
  
  def sanitize_inputs
    self.title = title&.strip
    self.content = content&.strip if content
  end
end
