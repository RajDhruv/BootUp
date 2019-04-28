module DeviseWhitelist
	extend ActiveSupport::Concern
	included do 
		before_action :configure_params, if: :devise_controller?
	end
	
	def configure_params
	  	devise_parameter_sanitizer.permit(:sign_up,keys:[:username])
	  	devise_parameter_sanitizer.permit(:account_update,keys:[:username])
	end
end