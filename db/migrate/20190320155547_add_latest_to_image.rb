class AddLatestToImage < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :latest, :boolean
  end
end
