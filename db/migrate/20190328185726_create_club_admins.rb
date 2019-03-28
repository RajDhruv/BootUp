class CreateClubAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :club_admins do |t|
      t.belongs_to :club, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
