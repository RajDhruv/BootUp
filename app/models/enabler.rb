class Enabler < ApplicationRecord
	belongs_to :enable,polymorphic:true
	belongs_to :timeline
	belongs_to :author,class_name:'User'
	scope :friends_posts,->(user) {where(timeline:Timeline.where(user:user.friends))}
	scope :clubs_posts,->(user){where(timeline:Timeline.where(club:user.clubs))}
	scope :all_enablers, ->(user) { friends_posts(u).or(clubs_posts(u)) }
	def name
		self.enable.name rescue "No Name"
	end


end
