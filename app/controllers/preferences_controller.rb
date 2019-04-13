class PreferencesController < ApplicationController
  def change_panel_color
  	current_user.preference.update_panel_color(params[:color])
  	render :nothing=>true
  end

  def change_panel_image_visibility
  end
end
