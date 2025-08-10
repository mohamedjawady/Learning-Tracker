class AddTagsToNotes < ActiveRecord::Migration[7.1]
  def change
    add_column :notes, :tags, :string
  end
end
