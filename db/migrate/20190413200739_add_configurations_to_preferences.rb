class AddConfigurationsToPreferences < ActiveRecord::Migration[5.2]
  def change
    add_column :preferences, :display_panel_image, :boolean
    add_column :preferences, :image_selected, :string
  end
end
