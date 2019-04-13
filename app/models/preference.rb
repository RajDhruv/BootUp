class Preference < ApplicationRecord
  belongs_to :user
  has_many :images, as: :imageable, dependent: :destroy
  enum panel_color:{black:0 ,azure:1 ,green:2 ,orange:3 ,red:4 ,purple:5 }
  before_create :set_default_values 

  def update_panel_color(color)
  	#TODO: need to secure send method so that unwanted value in params is handled
  	self.send(color+"!")
  end

  def set_default_values
  	self.panel_color=0
  	self.display_panel_image = false
  end
end
