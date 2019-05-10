class FriendshipController < ApplicationController
	layout "lbd4_application"
	before_action :find_friend,only:[:addFriend,:decision]

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
		@pending_users = current_user.requested_friends.page(params[:page]).per(10)
		render partial:"friendship_router.js.erb",locals:{from: :pendingUsers}
	end

	def addFriend
		current_user.friend_request(@friend)
		Notification.create(actor:current_user,recipient:@friend,notifiable:current_user,action:"sent you a friend Request")
		render partial:"friendship_router.js.erb",locals:{from: :addFriend,notice:"Request Sent",type:"success"}
	end
	def decision
		if params[:status]=="1"
			current_user.accept_request @friend
			Notification.create(actor:current_user,recipient:@friend,notifiable:current_user,action:"accepted your friend request")
			render partial:"friendship_router.js.erb",locals:{from: :decision,notice:"Accepted",type:"success"}
		else
			current_user.decline_request @friend
			Notification.create(actor:current_user,recipient:@friend,notifiable:current_user,action:"declined your friend request")
			render partial:"friendship_router.js.erb",locals:{from: :decision,notice:"Rejected",type:"error"}
		end
	end

	private

	def find_friend
		@friend = User.find_by_id(params[:id])
	end
end
