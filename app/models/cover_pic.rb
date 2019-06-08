class CoverPic < ApplicationRecord
  belongs_to :profile
  has_many :images, as: :imageable, dependent: :destroy
  
end
