# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dhruv=User.create(email:"raj.drv@gmail.com",username:"dhruv",password:"pleomaxX1!",password_confirmation:"pleomaxX1!")
puts "Dhruv Created"
faraz=User.create(email:"faraznoor75@gmail.com",username:"faraz",password:"pleomaxX1!",password_confirmation:"pleomaxX1!")
puts "Faraz Created"

Club.create(name:"Faraz Private",description:"Some sassy Descripttion",active:true,membership_type:1,owner_is:faraz)
puts "Faraz Private Created"


Club.create(name:"Dhruv Private",description:"Some sassy Descripttion",active:true,membership_type:1,owner_is:dhruv)
puts "Dhruv Private Created"