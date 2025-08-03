class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.text :description
      t.string :instructor
      t.string :platform
      t.string :url
      t.integer :status, default: 0
      t.date :start_date
      t.date :target_completion_date
      t.integer :total_duration_hours
      t.string :difficulty_level

      t.timestamps
    end
    
    add_index :courses, :status
    add_index :courses, :title
  end
end
