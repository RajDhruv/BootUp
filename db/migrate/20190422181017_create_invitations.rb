class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.references :club, foreign_key: true
      t.integer :approver_id
      t.integer :requester_id
      t.integer :status
      t.integer :invite_type
      t.timestamps
    end
  end
end
