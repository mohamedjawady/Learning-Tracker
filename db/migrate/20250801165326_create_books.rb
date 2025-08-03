class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.text :description
      t.string :isbn
      t.integer :status
      t.date :start_date
      t.date :target_completion_date
      t.integer :current_page
      t.integer :total_pages

      t.timestamps
    end
  end
end
