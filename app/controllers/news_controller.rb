class NewsController < ApplicationController
  def index
  	@timeline_posts = Enabler.news_feed(current_user).includes(:enable).order(created_at: :desc).page(params[:page]).per(10)
  	render partial: 'news.js.erb', locals:{from: :index}
  end
end
