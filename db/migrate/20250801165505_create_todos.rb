class CreateTodos < ActiveRecord::Migration[7.1]
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description
      t.string :priority
      t.date :due_date
      t.boolean :completed
      t.datetime :completed_at

      t.timestamps
    end
  end
end
