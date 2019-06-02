class Like < ApplicationRecord
  belongs_to :user
  belongs_to :liked,polymorphic: true,dependent: :destroy
end
