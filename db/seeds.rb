# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'
 
################################################ Create Users 
2.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

################################################ Create Lists 

list_array = []

(1..4).each do 
  
  list_array << List.create!(
  user:       users.sample, 
  title:      Faker::Lorem.sentence,
  body:       Faker::Lorem.paragraph,
  )
  
end

lists = List.all
  
################################################ Create Items 

list_array.each do |list|
  (1..20).each do
  Item.create!(
  list_id:    list.id, 
  name:       Faker::Lorem.sentence,    
  )
  end
end

items = Item.all

################################################ Alert 

# Create a member
member = User.new(
  name:     'Member User',
  email:    'admin@example.com',
  password: 'helloworld',
)
member.skip_confirmation!
member.save!
  
################################################ Alert 

puts "Seed finished"
puts "#{User.count} Users created"
puts "#{List.count} List created"
puts "#{Item.count} Items created"  
