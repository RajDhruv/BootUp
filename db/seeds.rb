# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = []
preferences = []
profiles = []
timelines = []

50.times do |index|
	users<<{email:"user_#{index+1}@example.com",username:"user_#{index+1}",encrypted_password:"$2a$11$4lJUFHKKnxdodq8lGqETYOE2sfcME4aHDikEqbf3y0iSrq0QiNuYy"}
	profiles<<{user_id:index+1}
	preferences<<{user_id:index+1,display_panel_image:true,panel_color:[0,1,2,3,4,5].sample,image_selected:['sidebar-1.jpg','sidebar-2.jpg','sidebar-3.jpg','sidebar-4.jpg','sidebar-5.jpg'].sample }
	timelines<<{timeable_type:"User",timeable_id:index+1}
end

User.import!(users)#password is 123456
puts "50 users created default password is : 123456"
Profile.import!(profiles)
puts "50 profiles created"
Preference.import!(preferences)
puts "50 preferences created"
Timeline.import!(timelines)
puts "50 timelines created"


dhruv=User.create(email:"raj.drv@gmail.com",username:"dhruv",password:"pleomaxX1!",password_confirmation:"pleomaxX1!")
puts "Dhruv Created"

faraz=User.create(email:"faraznoor75@gmail.com",username:"faraz",password:"pleomaxX1!",password_confirmation:"pleomaxX1!")
puts "Faraz Created"


faraz_pvt = Club.create(name:"Faraz Private",description:"Some sassy Descripttion",active:true,membership_type:1,owner_is:faraz)
puts "Faraz Private Created"

dhruv_pvt = Club.create(name:"Dhruv Private",description:"Some sassy Descripttion",active:true,membership_type:1,owner_is:dhruv)
puts "Dhruv Private Created"

User.first(25).each do |user|
	faraz_pvt.users<<user
end
puts "first 25 users are members of faraz private"
(User.last(27) - User.last(2)).each do |user|
	dhruv_pvt.users<<user
end
puts "next 25 are members of dhruv private"

#Friendship

User.first(25).each do |user|
	user.friend_request faraz
	faraz.accept_request user
end




