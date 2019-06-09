class RegistrationsController < Devise::RegistrationsController  
    respond_to :json
    layout "lbd4_application"

    def edit
    	respond_to do |format|
    		format.js{ render partial: 'devise/devise_router.js.erb', locals:{from: :edit}}
    	end
    end

end 