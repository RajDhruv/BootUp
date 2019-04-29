class Club < ApplicationRecord

	has_and_belongs_to_many :users,-> { distinct } do
	  def << (value)
	    super value rescue ActiveRecord::RecordNotUnique
	  end
	end
	has_many :club_admins
	has_many :admins, through: :club_admins, class_name: "User"
	
	has_many :invitations
	has_many :club_admins,dependent: :destroy
	has_many :admins, through: :club_admins, class_name: "User"
	enum membership_type:{ public_club:0, private_club:1, invite_only:2 }
	belongs_to :owner_is,class_name:"User",foreign_key: :owner
	# before_create :set_owner
	# def set_owner
	# 	self.owner=current_user.id
	# end
	def has_admin?(user)
		self.admins.include? user
	end

	def include?(user)
		self.users.include? user
	end

	def invitation_exist?(user)
		return self.invitations.where(requester:user,status:0).any?
	end

end

