class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	#protect_from_forgery prepend: true
	#layout "lbd4_application"
end
