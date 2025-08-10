class AddPdfFileToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :pdf_file, :string
  end
end
