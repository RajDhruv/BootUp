class CommunitiesController < ApplicationController
  layout "lbd4_application"
  before_action :set_club, only: [:show,:join_public,:edit,:update,:destroy,:ask_private]
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
  	@owned_clubs=Club.where(owner:current_user.id).page(params[:page]).per(10)
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
  	render partial:"community_router.js.erb",locals:{from: :show}
  end


  def join_public
  	@club.users<<current_user
  	render partial:"community_router.js.erb",locals:{from: :join_public,notice:"Joined Successfully"}
  end

  def ask_private
  	@invite=Invitation.create(club:@club,requester_id:current_user.id,status: 0,invite_type:0)
  	@club.admins.each do |admin|
  		@notification=Notification.new(notify:admin,content:"#{current_user.display_name} has asked to join club #{@club.name}")
  		@notification.invitation_id=@invite.id
  		@notification.save
  	end
  	#TODO make this code efficient
  	@owner=User.find_by_id(@club.owner)
  	@notification=Notification.new(notify:@owner,content:"#{current_user.display_name} has asked to join club #{@club.name}")
  	@notification.invitation_id=@invite.id
  	@notification.save
  	render partial:"community_router.js.erb",locals:{from: :ask_private,notice:"Invitation Sent"}
  end

  private

  def club_params
  	params.require(:club).permit(:name, :description,:membership_type,:active)
  end

  def set_club
  	@club=Club.find_by_id(params[:id])
  end

  def get_notifications
  	@notifications=current_user.notifications
  end
end
