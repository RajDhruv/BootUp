class Timeline < ApplicationRecord
	belongs_to :timeable,polymorphic:true
	has_many :enablers,dependent: :destroy
	def subscribers
		case self.timeable.class.to_s
			when 'User'
				self.timeable.friends.pluck(:id)
			when 'Club'
				self.timeable.users.pluck(:id)
		end
	end
end
