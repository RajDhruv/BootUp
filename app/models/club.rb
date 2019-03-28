class Club < ApplicationRecord
	has_and_belongs_to_many :users
	has_many :club_admins
	has_many :admins, through: :club_admins, class_name: "User"
	#before_create :set_owner
	def set_owner
		self.owner=current_user.id
	end
end

