class CommentsController < ApplicationController
	before_action :set_enabler
	def index
		@comments = Comment.where(commentable:@enabler)
		@comment = Comment.new
		render partial: 'comment_router.js.erb', locals:{from: :index}
	end

	def create
		@comment = Comment.new comment_params
		@comment.author = current_user
		@comment.commentable = @enabler
		@comment.save
		Notification.create(actor:current_user,recipient:@enabler.author,notifiable:@enabler,action:"Commented On Your Post")
		render partial: 'comment_router.js.erb', locals:{from: :create,notice: "Comment Created"},type:"success"
	end

	private
	def comment_params
		params.require(:comment).permit(:description)
	end

	def set_enabler
		@enabler = Enabler.find_by_id(params[:id])
	end
end