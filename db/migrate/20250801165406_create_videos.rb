class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.integer :order_number
      t.integer :duration_minutes
      t.integer :watched_minutes
      t.boolean :completed
      t.datetime :completed_at
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
