class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	#protect_from_forgery prepend: true
	include DeviseWhitelist
	include NotificationPanel

	def populate_timeline(timeline_for)
		@timeline = timeline_for.timeline
    	@timeline_posts = Enabler.where(timeline: @timeline).order('created_at desc').page(params[:page]).per(15)
	end
end
