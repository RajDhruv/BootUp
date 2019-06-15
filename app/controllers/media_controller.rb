class MediaController < ApplicationController
  before_action :set_timeline, only: [:new,:create]

  def new
  	@medium=Medium.new
    render partial: 'medium_router.js.erb', locals:{from: :new}
  end

  def create
  end
  private 
  def set_timeline
    @timeline= Timeline.find params[:timeline_id]
  end
end
