class CommunitiesController < ApplicationController
  #layout "lbd4_application"
  def index
  	@all_public_communities=Club.where(membership_type:"public_club")
  	@all_private_communities=Club.where(membership_type:"private_club")
  	@my_clubs=current_user.clubs
  	@owned_clubs=Club.where(owner:current_user.id)
  	render partial:"community_router.js.erb",locals:{from: :index}
  end

  def new
  	@community=Club.new
  	render partial:"community_router.js.erb",locals:{from: :new}
  end

  def create
  	club=Club.new(club_params)
  	club.owner=current_user.id
  	club.save
  	redirect_to communities_path
  end

  private

  def club_params
  	params.require(:club).permit(:name, :description,:membership_type,:active)
  end
end
