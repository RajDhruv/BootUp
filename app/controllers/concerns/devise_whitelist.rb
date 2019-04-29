module DeviseWhitelist
	extend ActiveSupport::Concern
	included do 
		before_action :configure_params, if: :devise_controller?
	end
	
	def configure_params
		added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
		devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
		devise_parameter_sanitizer.permit :account_update, keys: added_attrs
	end
end