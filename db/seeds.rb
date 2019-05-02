# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




50.times do |index|
	User.create(email:"user_#{index}@example.com",username:"user_#{index}",password:"123456",password_confirmation:"123456")
end
puts "50 users created"

dhruv=User.create(email:"raj.drv@gmail.com",username:"dhruv",password:"pleomaxX1!",password_confirmation:"pleomaxX1!")
puts "Dhruv Created"

faraz=User.create(email:"faraznoor75@gmail.com",username:"faraz",password:"pleomaxX1!",password_confirmation:"pleomaxX1!")
puts "Faraz Created"


faraz_pvt = Club.create(name:"Faraz Private",description:"Some sassy Descripttion",active:true,membership_type:1,owner_is:faraz)
puts "Faraz Private Created"

dhruv_pvt = Club.create(name:"Dhruv Private",description:"Some sassy Descripttion",active:true,membership_type:1,owner_is:dhruv)
puts "Dhruv Private Created"

(1..25).each do |id|
	faraz_pvt.users<<User.find(id)
end

(26..50).each do |id|
	dhruv_pvt.users<<User.find(id)
end



