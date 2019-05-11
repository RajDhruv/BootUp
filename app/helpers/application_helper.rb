module ApplicationHelper
	def profile_display_image(user)
		user_profile=user.profile_image
	    user_profile=user_profile.empty? ? asset_path("default_logos/default_profile.png") : user_profile
	end
	
	def bio_display user
		(user.profile.bio.nil?) ? "My Bio" : user.profile.bio
	end
end
