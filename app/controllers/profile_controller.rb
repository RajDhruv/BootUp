class ProfileController < ApplicationController
  before_action :set_user, only:[:show]
  def update
  	@profile=current_user.profile
  	@profile.update(profile_params)
    session[:noty_type]='success'
    render partial:"router.js.erb",locals:{from: :update}
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
    if current_user == @user || current_user.friends.include?(@user)
      @timeline_posts = Enabler.where(timeline: @user.timeline).order('created_at desc').page(params[:page]).per(15)
    end
    render partial:"router.js.erb",locals:{from: :show}
  end
  def image
  	@image=Image.new
    @image.location=params[:file]
    @image.imageable=current_user.profile
    @image.save!
    render partial:"router.js.erb",locals:{from: :image}
  end

  def make_dp
    @image=Image.find(params[:id])
    @image.update(latest:true)
    render partial:"router.js.erb",locals:{from: :make_dp}
  end
  def profile_image_carousel
    @images=current_user.images
    render partial:"router.js.erb",locals:{from: :profile_image_carousel}
  end
  def close_carousel
    render partial:"router.js.erb",locals:{from: :close_carousel}
  end

  def update_bio
    current_user.profile.update_attribute(:bio, params[:update_text])
    render partial:"router.js.erb",locals:{from: :update_bio}
  end
  private 
  	def profile_params
      params.require(:profile).permit(:first_name, :last_name,:dob,:country)
    end
    def set_user
      @user = User.find_by_id(params[:id])
    end
end
