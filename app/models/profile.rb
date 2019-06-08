class Profile < ApplicationRecord
  belongs_to :user
  has_many :images, as: :imageable, dependent: :destroy
  has_one :cover_pic, dependent: :destroy
  after_create :create_cover_pic

  def is_complete?
  	unless self.first_name? && self.last_name? && self.dob? && self.country? && self.images.any?
  		return false
  	end
  	return true
  end

  def create_cover_pic
    unless self.cover_pic.present?
      CoverPic.create(profile:self)
    end
  end

  def name
  	"#{self.first_name} #{self.last_name}".strip.empty? ? self.user.name : "#{self.first_name} #{self.last_name}"
  end

end
