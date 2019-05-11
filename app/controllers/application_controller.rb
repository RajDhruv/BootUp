class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	#protect_from_forgery prepend: true
	include DeviseWhitelist
	include NotificationPanel
end
