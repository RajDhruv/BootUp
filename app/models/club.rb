class Club < ApplicationRecord
	has_and_belongs_to_many :users,-> { distinct } do
	  def << (value)
	    super value rescue ActiveRecord::RecordNotUnique
	  end
	end
	has_many :club_admins,dependent: :destroy
	has_many :admins, through: :club_admins, class_name: "User"
	enum membership_type:{ public_club:0, private_club:1, invite_only:2 }
	# before_create :set_owner
	# def set_owner
	# 	self.owner=current_user.id
	# end
	def owner_is?
		User.find_by_id(self.owner)
	end
	def has_admin?(user)
		self.admins.include? user
	end

	def include?(user)
		self.users.include? user
	end

end

