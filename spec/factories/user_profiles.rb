FactoryGirl.define do
  factory :user_profile do
    picture Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/app/assets/images/default_profile.png')))
    full_name 'Test User'
    username 'testuser'
    phone_number '0999-999-9999'
    location 'Hogwarts'
    association :user, factory: :user
  end
end
