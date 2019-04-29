class PreferencesController < ApplicationController
  def change_panel_color
  	current_user.preference.update_panel_color(params[:color])
  	render :nothing=>true
  end

  def toggle_background_image
  	current_user.preference.toggle_background_image
  	render partial: 'toggle_background_image.js.erb'
  end

  def set_background_image
  	image_name=params[:asset_name]
  	current_user.preference.set_background_image(image_name)
  	render :nothing=>true
  end
end
