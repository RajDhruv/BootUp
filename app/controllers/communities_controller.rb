class CommunitiesController < ApplicationController
  layout "lbd4_application"
  before_action :set_club, only: [:show,:join_public,:edit,:update,:destroy,:ask_private,:approve_invite]
  before_action :get_notifications
  def index
  	@my_clubs=current_user.clubs.page(params[:page]).per(10)
  	render partial:"community_router.js.erb",locals:{from: :index}
  end

  def public
  	@all_public_communities=Club.where('membership_type=0 and owner != ?',current_user.id).page(params[:page]).per(10)
  	render partial:"community_router.js.erb",locals:{from: :public}
  end

  def private_club
  	@all_private_communities=Club.where('membership_type=1 and owner != ?',current_user.id).page(params[:page]).per(10)
  	render partial:"community_router.js.erb",locals:{from: :private_club}
  end

  def owned_club
  	@owned_clubs=Club.where(owner_is:current_user).page(params[:page]).per(10)
  	render partial:"community_router.js.erb",locals:{from: :owned_club}
  end

  def new
  	@community=Club.new
  	render partial:"community_router.js.erb",locals:{from: :new}
  end

  def create
  	@club=Club.new(club_params)
  	@club.owner=current_user.id
  	@club.save
  	render partial:"community_router.js.erb",locals:{from: :create,notice:"Club Created",type:"success"}
  end

  def edit
  	render partial:"community_router.js.erb",locals:{from: :edit}
  end

  def update
  	@club.update(club_params)
  	@my_clubs=Club.where(owner:current_user.id).page(params[:page]).per(10)
  	render partial:"community_router.js.erb",locals:{from: :index,notice:"#{@club.name} Updated",type:"success"}
  end

  def destroy
  	@club.destroy
  	render partial:"community_router.js.erb",locals:{from: :destroy,notice:"#{@club.name} Destroyed",type:"error"}
  end

  def show
    #TODO need to make this ajax
  	render partial:"community_router.js.erb",locals:{from: :show}
  end


  def join_public
  	@club.users<<current_user
  	render partial:"community_router.js.erb",locals:{from: :join_public,notice:"Joined Successfully"}
  end

  def ask_private
  	@invite=Invitation.create(club:@club,requester:current_user,status: 0,invite_type:0)
  	@club.admins.each do |admin|
  		Notification.create(actor:current_user,recipient:admin,notifiable:@club,action:"requested to join")
  	end
  	#TODO make this code efficient
  	Notification.create(actor:current_user,recipient:@club.owner_is,notifiable:@club,action:"requested to join")
  	render partial:"community_router.js.erb",locals:{from: :ask_private,notice:"Invitation Sent"}
  end
  def approve_invite
    @invitee = User.find_by_id(params[:invitee_id])
  	if params[:status]=="1"
  		@club.users<<@invitee
  		Invitation.find_by_id(params[:invitation]).update(status:1,approver_id:current_user.id)
      Notification.create(actor:current_user,recipient:@invitee,notifiable:@club,action:"Approved your request to join")
  		notice="Accepted"
  		type="success"
  	else
  		Invitation.find_by_id(params[:invitation]).update(status:-1,approver_id:current_user.id)
      Notification.create(actor:current_user,recipient:@invitee,notifiable:@club,action:"Rejected your request to join")
  		notice="Rejected"
  		type="error"
  	end
  	render partial:"community_router.js.erb",locals:{from: :approve_invite,notice:notice,type:type}
  end
  private

  def club_params
  	params.require(:club).permit(:name, :description,:membership_type,:active)
  end

  def set_club
  	@club=Club.find_by_id(params[:id])
  end

  def get_notifications
  	@notifications=current_user.notifications.unread
  end
end
