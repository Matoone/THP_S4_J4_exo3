# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "faker"

User.destroy_all
City.destroy_all
Gossip.destroy_all
Tag.destroy_all
PrivateMessage.destroy_all

users = []
10.times do
  user = {first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.paragraph, email: Faker::Internet.email, age: Faker::Number.between(from: 14, to: 100).to_i}
  users.push(user)
end

cities = []
10.times do
  city = {name: Faker::Address.city, zip_code: Faker::Address.zip_code}
  cities.push(city)
end

users.each_with_index do |user, index|
 user_model = User.new(user)
 user_model.city = City.create(cities[index])
  user_model.save
  puts "#{index + 1} users generated."
  puts "#{index + 1} cities generated."
end
gossips = []
20.times do |i|
  gossip = Gossip.new({title: Faker::Book.title, content: Faker::Lorem.paragraphs.join(' '), user: User.all.sample})
  gossip.save
  gossips.push(gossip)
  puts "#{i} gossips generated."
end
tags = []
10.times do |i|
  tag = Tag.new({title: "#" + Faker::Lorem.word})
  tag.save
  tags.push(tag)
  puts "#{i} tags generated."
end

gossips.each_with_index do |gossip, index|
  r = rand(1..3)
  gossip.tags.push(Tag.all.sample)
  if r >= 2
    gossip.tags.push(Tag.all.sample)
  end
  puts "Tag added to gossip #{index}"
end

pms = []
receivers = []
senders = []

10.times do |i|
   random_receiver = User.all.sample
   random_sender = User.all.sample
   pm = PrivateMessage.new({content: Faker::Lorem.paragraphs.join(' ')})
   pm.sender = random_sender
   pm.recipient = random_receiver
   pm.save

   puts "Private message #{i} added"
end

# cities.each_with_index do |city, index|
#   City.create(city)
#   puts "#{index + 1} cities generated."
# end

# User.all.update(city: City.all.sample)