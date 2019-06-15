class Attachment < ApplicationRecord
	belongs_to :attachable,polymorphic: true
	mount_uploader :location, AvatarUploader
end
