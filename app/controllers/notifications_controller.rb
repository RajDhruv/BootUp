class NotificationsController < ApplicationController
  before_action :get_notifications,only:[:seen]
  def seen
  	@notifications.update_all(read_at:Time.now)
  	render partial:'notification_router',locals:{from: :seen}
  	#byebug
  end

  def index
  	@notifications = current_user.notifications.latest.page(params[:page]).per(20)
  	render partial:'notification_router',locals:{from: :index}
  end

  private
  def get_notifications
  	@notifications=current_user.notifications.recent
  end

end
