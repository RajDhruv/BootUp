class Notification < ApplicationRecord
	include Rails.application.routes.url_helpers
	belongs_to :notify,polymorphic: true
	attr_accessor :invitation_id

	after_create :set_notification_link 

	def set_notification_link
		unless (self.invitation_id.nil?)
			self.link=show_notification_path(id:self.id,invite_id:Invitation.find_by_id(self.invitation_id))
			self.save
		end
		
	end 
end
