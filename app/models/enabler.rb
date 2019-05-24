class Enabler < ApplicationRecord
	belongs_to :enable,polymorphic:true
	belongs_to :timeline
	belongs_to :author,class_name:'User'

	def name
		self.enable.name rescue "No Name"
	end
end
