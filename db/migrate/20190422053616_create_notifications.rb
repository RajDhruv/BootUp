class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :recipient_id
      t.integer :actor_id
      t.datetime :read_at
      t.string :action
      t.references :notifiable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
