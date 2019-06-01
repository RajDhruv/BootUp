class BlogsController < ApplicationController
  before_action :set_blog, only: [:edit,:update,:delete,:show]
  before_action :set_timeline, only: [:new,:create]

  def new
    @blog=Blog.new
    render partial: 'blogs_router.js.erb', locals:{from: :new}
  end

  def create
    @blog=Blog.new(blog_params)
    @blog.timeline=@timeline
    @blog.author=current_user
    @blog.save
    render partial:"blogs_router.js.erb",locals:{from: :create,notice:"Blog '#{@blog.title}' Created",type:"success"}
  end

  def edit
    @timeline=@blog.enabler.timeline
    render partial: 'blogs_router.js.erb', locals:{from: :edit}
  end

  def update
    @blog.update(blog_params)
    render partial:"blogs_router.js.erb",locals:{from: :update,notice:"Blog '#{@blog.title}' Updated",type:"warning"}

  end

  def delete
  end

  def show
  end

  private

  def set_blog
    @blog= Blog.find params[:id]
  end

  def set_timeline
    @timeline= Timeline.find params[:timeline_id]
  end

  def blog_params
    params.require(:blog).permit(:title, :description)
  end
end