class BlogsController < ApplicationController
  before_action :set_blog, only: [:edit,:update,:delete,:show]
  def new
    @blog=Blog.new
    render partial: 'blogs_router.js.erb', locals:{from: :new}
  end
  def create
    @blog=Blog.new(blog_params)
    @blog.timeline=current_user.timeline
    @blog.author=current_user
    @blog.save
    render partial:"blogs_router.js.erb",locals:{from: :create,notice:"Blog '#{@blog.title}' Created",type:"success"}
  end
  def edit
  end
  def update
  end
  def delete
  end
  def show
  end
  private
  def set_blog
    @blog= Blog.find params[:id]
  end
    def blog_params
      params.require(:blog).permit(:title, :description)
    end
end