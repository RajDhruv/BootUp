class Image < ApplicationRecord
  belongs_to :imageable,polymorphic: true
  mount_uploader :location, AvatarUploader

end
