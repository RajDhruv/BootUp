class Preference < ApplicationRecord
  belongs_to :user
  has_many :images, as: :imageable, dependent: :destroy
  enum panel_color:{black:0 ,azure:1 ,green:2 ,orange:3 ,red:4 ,purple:5 }
  before_create :set_default_values 

  def update_panel_color(color)
  	#TODO SECURITY : need to secure send method so that unwanted value in params is handled
  	self.send(color+"!")
  end

  def set_default_values
  	self.panel_color=[0,1,2,3,4,5].sample
  	self.image_selected = ['sidebar-1.jpg','sidebar-2.jpg','sidebar-3.jpg','sidebar-4.jpg','sidebar-5.jpg'].sample
    self.display_panel_image = true
  end
  
  def toggle_background_image
  	if self.display_panel_image.nil?
  		self.display_panel_image = false
  	end
  	self.update_attribute("display_panel_image",!(self.display_panel_image))
  end

  def set_background_image(asset_name)
  	self.update_attribute("image_selected",asset_name)
  end

end
