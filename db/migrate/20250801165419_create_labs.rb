class CreateLabs < ActiveRecord::Migration[7.1]
  def change
    create_table :labs do |t|
      t.string :title
      t.text :description
      t.integer :order_number
      t.boolean :completed
      t.datetime :completed_at
      t.text :notes
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
