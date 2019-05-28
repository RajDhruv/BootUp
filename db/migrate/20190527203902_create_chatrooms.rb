class CreateChatrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chatrooms do |t|
      t.string :name
	  t.integer :chatroom_type
	  t.integer :created_by
	  t.boolean :is_private

      t.timestamps
    end
  end
end
