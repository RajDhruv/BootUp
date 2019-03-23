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
  	image=Image.new
    image.location=params[:file]
    image.imageable=current_user.profile
    image.save!
    redirect_to root_path
  end

  def update_bio
    current_user.profile.update_attribute(:bio, params[:update_text])
    render partial:"router.js.erb",locals:{from: :update_bio}
  end
  private 
  	def profile_params
      params.require(:profile).permit(:first_name, :last_name,:dob,:country)
    end
end
