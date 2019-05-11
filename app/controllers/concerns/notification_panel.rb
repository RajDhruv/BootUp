module NotificationPanel
	extend ActiveSupport::Concern
	included do 
		before_action :get_notifications
	end
	
	def get_notifications
  		@notifications=current_user.notifications.unread if user_signed_in?
  	end
end