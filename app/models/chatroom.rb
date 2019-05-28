class Chatroom < ApplicationRecord
	has_many :chatroom_users
	has_many :users, through: :chatroom_users
	has_many :messages
	after_create :map_users_for_chat

	def map_users_for_chat
		if self.chatroom_type==0
			users=self.name.split("_")
			self.chatroom_users.create(user_id: users[0])
			self.chatroom_users.create(user_id: users[1])
		end
	end
end
