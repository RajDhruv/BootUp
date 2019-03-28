class AddOwnerToClubs < ActiveRecord::Migration[5.2]
  def change
    add_column :clubs, :owner, :integer
  end
end
