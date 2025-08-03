class CreateChapters < ActiveRecord::Migration[7.1]
  def change
    create_table :chapters do |t|
      t.string :title
      t.text :description
      t.integer :order_number
      t.boolean :completed
      t.datetime :completed_at
      t.references :course, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.integer :page_start
      t.integer :page_end

      t.timestamps
    end
  end
end
