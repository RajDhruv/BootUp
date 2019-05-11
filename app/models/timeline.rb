class Timeline < ApplicationRecord
	belongs_to :timeable,polymorphic:true
	has_many :enablers,dependent: :destroy
end
