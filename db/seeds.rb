# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# db/seed.rb

User.create(
  email: 'user@example.com',
  password: 'password'
)

10.times do |x|
  name = Faker::HarryPotter.character
  domain = Faker::Internet.domain_name
  User.create(
    full_name: name,
    username: name.strip.downcase,
    phone_number: '0999-99999' + x.to_s,
    location: Faker::HarryPotter.location,
    email: name.strip.downcase + '@' + domain,
    password: 'password'
  )
end

users = User.all
users.each do |user|
  Post.create(
    body: Faker::HarryPotter.quote,
    user_id: user.id
  )
end

