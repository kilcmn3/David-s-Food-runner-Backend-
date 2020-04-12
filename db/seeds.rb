# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require  'faker'

puts "User Creatin"
User.destroy_all
puts "Restaurant Creating!"
Restaurant.destroy_all

full_address = Faker::Address.street_address + "," + Faker::Address.city + "," + Faker::Address.state + "," + Faker::Address.zip_code

10.times do 
    User.create(user_name: Faker::Internet.username, password:'123', name: Faker::Movies::HarryPotter.character, email:Faker::Internet.free_email)
end

10.times do
 Restaurant.create(name: Faker::Restaurant.name, address:full_address, contact: Faker::PhoneNumber.cell_phone, email:Faker::Internet.email, user_id: rand(1..10) )
end

# Need to test for api