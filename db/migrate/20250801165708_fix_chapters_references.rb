class FixChaptersReferences < ActiveRecord::Migration[7.1]
  def change
    change_column_null :chapters, :course_id, true
    change_column_null :chapters, :book_id, true
  end
end
