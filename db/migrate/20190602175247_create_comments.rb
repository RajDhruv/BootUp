class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :author_id
      t.string :commentable_type
      t.integer :commentable_id
      t.text :description
      t.timestamps
    end
  end
end
