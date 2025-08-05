class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.string :title, null: false
      t.text :content
      t.integer :parent_id
      t.integer :position, default: 0
      t.string :tags
      t.integer :user_id
      t.references :notable, polymorphic: true, null: true
      t.boolean :is_folder, default: false
      t.string :color, default: '#ffffff'

      t.timestamps
    end
    
    add_index :notes, :parent_id
    add_index :notes, [:notable_type, :notable_id]
    add_index :notes, :position
  end
end
