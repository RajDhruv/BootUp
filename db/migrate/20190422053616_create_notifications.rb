class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :content
      t.string :link
      t.string :viewed
      t.references :notify, polymorphic: true, index: true
      t.timestamps
    end
  end
end
