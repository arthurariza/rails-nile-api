class AddAuthorToBook < ActiveRecord::Migration[7.0]
  def change
    add_reference :books, :author, null: false, foreign_key: true
    remove_column :books, :author
  end
end
