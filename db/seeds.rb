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
UserProfile.delete_all

ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'users'")
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'posts'")
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'relationships'")
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'user_profiles'")

user = User.new(
  user_profile_attributes: {
    full_name: 'User Example',
    username: 'userexample',
    phone_number: '0999-999990',
    location: 'Philippines',
    picture: File.open(File.join(Rails.root, 'app/assets/images/default_profile.png'))},
  email: 'user@example.com',
  password: 'password',
  confirmed_at: Time.now
)
user.skip_confirmation!
user.save!

50.times do |x|
  name = Faker::Name.name
  domain = Faker::Internet.domain_name
  picture = 'public/uploads/avatars/' + rand(13).to_s + '.jpg'
  user = User.new(
    user_profile_attributes: {
      full_name: name,
      username: name.gsub(/\s+/, '').downcase + x.to_s,
      phone_number: '0999-99999' + x.to_s,
      location: Faker::Address.country,
      picture: File.open(File.join(Rails.root, picture))},
    email: name.gsub(/\s+/, '').downcase + x.to_s + '@' + domain,
    password: 'password'
  )
  x = x + 1
  user.skip_confirmation!
  user.save!
end

users = User.all
users.each do |user|
  Post.create!(
    body: Faker::HarryPotter.quote.truncate(160),
    user_id: user.id
  )
end

