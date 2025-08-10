class AddPageColumnsToChapters < ActiveRecord::Migration[7.1]
  def change
    add_column :chapters, :page_start, :integer
    add_column :chapters, :page_end, :integer
  end
end
