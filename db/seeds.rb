# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# db/seed.rb
User.delete_all
Post.delete_all
Relationship.delete_all

ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'users'")
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'posts'")
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'relationships'")

User.create!(
  full_name: 'User Example',
  username: 'userexample',
  phone_number: '0999-999990',
  location: 'Philippines',
  email: 'user@example.com',
  password: 'password',
  picture: File.open(File.join(Rails.root, 'app/assets/images/default_profile.png'))
)

20.times do |x|
  name = Faker::HarryPotter.character
  domain = Faker::Internet.domain_name
  User.create!(
    full_name: name,
    username: name.gsub(/\s+/, '').downcase + x.to_s,
    phone_number: '0999-99999' + x.to_s,
    location: Faker::Address.country,
    email: name.gsub(/\s+/, '').downcase + x.to_s + '@' + domain,
    password: 'password',
    picture: File.open(File.join(Rails.root, 'app/assets/images/default_profile.png'))
  )
  x = x + 1
end

users = User.all
users.each do |user|
  Post.create!(
    body: Faker::HarryPotter.quote,
    user_id: user.id
  )
end

