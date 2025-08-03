class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :author
      t.string :url
      t.text :description
      t.integer :status
      t.integer :estimated_read_time
      t.integer :time_spent

      t.timestamps
    end
  end
end
