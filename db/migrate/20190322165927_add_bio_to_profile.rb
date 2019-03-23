class AddBioToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :bio, :text
  end
end
