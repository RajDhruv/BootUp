class FriendshipController < ApplicationController
	layout "lbd4_application"
	before_action :find_friend,only:[:addFriend,:decision,:block,:unblock,:unfriend]

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
		received_from=params[:received_from]
		@user=@friend
		if params[:status]=="1"
			current_user.accept_request @friend
			Notification.create(actor:current_user,recipient:@friend,notifiable:current_user,action:"accepted your friend request")
			render partial:"friendship_router.js.erb",locals:{from: :accepted,notice:"Accepted",type:"success",received_from: received_from}
		else
			current_user.decline_request @friend
			Notification.create(actor:current_user,recipient:@friend,notifiable:current_user,action:"declined your friend request")
			render partial:"friendship_router.js.erb",locals:{from: :rejected,notice:"Rejected",type:"error",received_from: received_from}
		end
	end

	def block
		current_user.block_friend @friend
		render partial:"friendship_router.js.erb",locals:{from: :block,notice:"Blocked",type:"info"}
	end

	def unblock
		current_user.unblock_friend @friend
		current_user.friends<<@friend
		@friend.friends<<current_user
		render partial:"friendship_router.js.erb",locals:{from: :unblock,notice:"Unblocked",type:"success"}
	end

	def unfriend
		current_user.remove_friend @friend
		@user=@friend
		render partial:"friendship_router.js.erb",locals:{from: :unfriend,notice:"Unfriended",type:"error"}
	end

	private

	def find_friend
		@friend = User.find_by_id(params[:id])
	end
end
