class CreateEnablers < ActiveRecord::Migration[5.2]
  def change
    create_table :enablers do |t|
      t.string :enable_type
      t.integer :enable_id
      t.integer :timeline_id
      t.integer :author_id
      t.integer :view_count
      t.integer :like_count
      t.integer :comment_count

      t.timestamps
    end
  end
end
