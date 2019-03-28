class FixClubAdmin < ActiveRecord::Migration[5.2]
  def change
  	rename_column :club_admins, :user_id, :admin_id
  end
end
