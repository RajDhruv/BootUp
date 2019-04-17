class CommunitiesController < ApplicationController
  layout "lbd4_application"
  before_action :set_club, only: [:show,:join_public,:edit,:update,:destroy]
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

  private

  def club_params
  	params.require(:club).permit(:name, :description,:membership_type,:active)
  end

  def set_club
  	@club=Club.find_by_id(params[:id])
  end
end
