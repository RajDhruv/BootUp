class ProfileController < ApplicationController
  def update
  	@profile=current_user.profile
  	@profile.update(profile_params)

  	#byebug
  end

  def edit
  	if current_user.profile.present?
  		@profile=current_user.profile
  	else
  		@profile=Profile.create(user:current_user)
  	end
  	render partial:"router.js.erb",locals:{from: :edit}
  end

  def show
  end
  def image
  	byebug
  end

  private 
  	def profile_params
      params.require(:profile).permit(:first_name, :last_name,:dob,:country)
    end
end
