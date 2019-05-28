class AddRightPanelConfigurationToPreferences < ActiveRecord::Migration[5.2]
  def change
    add_column :preferences, :display_right_panel, :boolean
  end
end
