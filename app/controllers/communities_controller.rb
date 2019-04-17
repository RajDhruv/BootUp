class CommunitiesController < ApplicationController
  layout "lbd4_application"
  #before_action :set_communities_listing, only: [:index,:create]
  def index
  	@my_clubs=current_user.clubs.page(params[:page]).per(10)
  	render partial:"community_router.js.erb",locals:{from: :index}
  end

  def public
  	@all_public_communities=Club.where(membership_type:"public_club").page(params[:page]).per(10)
  	render partial:"community_router.js.erb",locals:{from: :public}
  end

  def private_club
  	@all_private_communities=Club.where(membership_type:"private_club").page(params[:page]).per(10)
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
  	club=Club.new(club_params)
  	club.owner=current_user.id
  	club.save
  	#Firing owned club query as my_club variable so as to render index page at my_clubs tab
  	@my_clubs=Club.where(owner:current_user.id).page(params[:page]).per(10)
  	render partial:"community_router.js.erb",locals:{from: :index,at_action: :creates,notice:"Club Created",type:"success"}
  	#TODO noty is not working
  end


  def show
  	@club=Club.find_by_id(params[:id])#.includes(:club_admins,:users)
  	render partial:"community_router.js.erb",locals:{from: :show}
  end

  private

  def club_params
  	params.require(:club).permit(:name, :description,:membership_type,:active)
  end

  def set_communities_listing
  	@all_public_communities=Club.where(membership_type:"public_club")
  	@all_private_communities=Club.where(membership_type:"private_club")
  	@my_clubs=current_user.clubs
  	@owned_clubs=Club.where(owner:current_user.id)
  end
end
