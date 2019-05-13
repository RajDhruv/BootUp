class CreateClubAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :club_admins do |t|
      t.belongs_to :club, foreign_key: true,unique:true
      t.belongs_to :user, foreign_key: true,unique:true

      t.timestamps
    end
  end
end
