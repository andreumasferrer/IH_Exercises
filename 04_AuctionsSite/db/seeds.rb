# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all

User.create(name: "Andreu Masferrer" ,
            email: "user@example.com",
            password: "123")

#Create users
10.times do |i|
  user = User.create(name: Faker::Name.name ,
                     email: Faker::Internet.email,
                     password: "123")

  #Create products
  rand(0..2).times do |j|
    user.products.create(title: Faker::Commerce.product_name,
                         description: Faker::Lorem.paragraph,
                         bidding_deadline: DateTime.current+rand(10..200),
                         minimum_bid: rand(0..100))
  end
end
