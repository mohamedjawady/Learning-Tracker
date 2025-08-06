# Search concern for models
module Searchable
  extend ActiveSupport::Concern
  
  included do
    scope :search, ->(query) { 
      return all if query.blank?
      where(search_condition, "%#{sanitize_sql_like(query)}%")
    }
  end
  
  class_methods do
    def search_condition
      searchable_fields.map { |field| "#{field} ILIKE ?" }.join(' OR ')
    end
    
    def searchable_fields
      %w[title description]
    end
  end
end
