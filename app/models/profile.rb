class Profile < ApplicationRecord
  belongs_to :user
  has_many :images, as: :imageable, dependent: :destroy

  def is_complete?
  	unless self.first_name? && self.last_name? && self.dob? && self.country? && self.images.any?
  		return false
  	end
  	return true
  end
end
