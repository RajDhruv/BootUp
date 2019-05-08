class FriendshipController < ApplicationController
	layout "lbd4_application"


	def index
		@dosts = current_user.friends.page(params[:page]).per(10)
		#byebug
		render partial:"friendship_router.js.erb",locals:{from: :index}
	end


	def allUsers
		@users = User.all.page(params[:page]).per(10)
		render partial:"friendship_router.js.erb",locals:{from: :allUsers}
	end

	def blockedUsers
		@blocked_users = current_user.blocked_friends.page(params[:page]).per(10)
		render partial:"friendship_router.js.erb",locals:{from: :blockedUsers}
	end

	def pendingUsers
		@pending_users = current_user.pending_friends.page(params[:page]).per(10)
		render partial:"friendship_router.js.erb",locals:{from: :pendingUsers}
	end
end
