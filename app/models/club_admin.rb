class ClubAdmin < ApplicationRecord
  belongs_to :club
  belongs_to :admin, class_name: 'User'
  # def admin_id
  # 	self.user_id
  # end
end
