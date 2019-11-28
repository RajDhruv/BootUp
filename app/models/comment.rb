class Comment < ApplicationRecord
	belongs_to :commentable,polymorphic: true
	belongs_to :author,class_name:'User'
	has_many :replies,class_name:'Comment',as: :commentable
	default_scope { order(created_at: :desc) }
	def likes_count
		Like.where(liked:self).count
	end
	
	def comments_count
		Comment.where(commentable:self).count
	end
end
