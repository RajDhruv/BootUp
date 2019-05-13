class Club < ApplicationRecord
	has_one :timeline,as: :timeable,dependent: :destroy
	has_and_belongs_to_many :users
	has_many :invitations,dependent: :destroy
	has_many :club_admins,dependent: :destroy
	has_many :admins, through: :club_admins, class_name: "User"
	enum membership_type:{ public_club:0, private_club:1, invite_only:2 }
	belongs_to :owner_is,class_name:"User",foreign_key: :owner
	after_create :create_timeline
  	#after_save :create_timeline
	scope :public_clubs, -> (user) {where('membership_type=0 and owner != ?',user.id)}
	scope :private_clubs, -> (user) {where('membership_type=1 and owner != ?',user.id)}
	scope :owned_clubs, -> (user) {where(owner_is:user)}
	def create_timeline
		unless self.timeline.present?
			Timeline.create(timeable:self)
		end
	end

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

