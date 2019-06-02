class Enabler < ApplicationRecord
	belongs_to :enable,polymorphic:true
	belongs_to :timeline
	belongs_to :author,class_name:'User'
	after_create :send_notifications
	scope :news_feed,->(user){where(timeline:user.subscribed_timeline)}
	def name
		self.enable.title rescue "No Name"
	end
	def send_notifications
		EnablerCreateJob.perform_later(self)
	end
	def notification_links(notification)
		message = "#{notification.actor.display_name} #{notification.action} #{notification.notifiable.name}"
		path = community_path(self)
		return message,path
	end
end
