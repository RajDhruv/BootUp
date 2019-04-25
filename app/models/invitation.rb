class Invitation < ApplicationRecord
  belongs_to :club
  enum status:{ pending:0 , accepted:1 , rejected:-1 },invite_type: { private_club:0 , invite_only:1 }
  #TODO multiple enum ka credit chodo!!!
  belongs_to :requester,class_name:"User"
  scope :pending,->{where(status:"pending")}
  #belongs_to :approver,class_name:"User"
end
