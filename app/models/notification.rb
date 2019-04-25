class Notification < ApplicationRecord
	include Rails.application.routes.url_helpers
	belongs_to :recipient,class_name:"User"
	belongs_to :actor,class_name:"User"
	belongs_to :notifiable,polymorphic: true
	scope :recent,->{where(read_at:nil)}
end