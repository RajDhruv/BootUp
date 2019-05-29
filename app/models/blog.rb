class Blog < ApplicationRecord
	has_one :enabler, as: :enable, dependent: :destroy
	attr_accessor :timeline, :author
	after_create :create_enabler

	def create_enabler
		Enabler.create(enable: self, timeline: timeline, author: author)
	end
end
