class Image < ApplicationRecord
  belongs_to :imageable,polymorphic: true
  mount_uploader :location, AvatarUploader
  before_save :make_default


  def make_default
  	self.imageable.images.update_all(latest:false)
  	self.latest = true
  end
end
