class NotificationsController < ApplicationController
  def seen
  	@notifications.update_all(read_at:Time.now)
  	render partial:'notifications/notification_router',locals:{from: :seen}
  	#byebug
  end

  def index
  	@latest_notifications = current_user.notifications.latest.page(params[:page]).per(20)
  	render partial:'notifications/notification_router',locals:{from: :index}
  end

end
