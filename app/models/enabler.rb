class Enabler < ApplicationRecord
	belongs_to :enable,polymorphic:true
end
