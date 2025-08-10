class AddNotesToLabs < ActiveRecord::Migration[7.1]
  def change
    add_column :labs, :notes, :text
  end
end
