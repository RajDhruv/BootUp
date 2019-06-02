class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.string :liked_type
      t.integer :liked_id
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
