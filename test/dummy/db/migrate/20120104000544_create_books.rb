class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.belongs_to :author
      t.text :title

      t.timestamps
    end
    add_index :books, :author_id
  end
end
