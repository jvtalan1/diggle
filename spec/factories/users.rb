FactoryGirl.define do
  factory :user do
    email 'test@user.com'
    password 'password'
    after(:build)   { |u| u.skip_confirmation_notification! }
    after(:create)  { |u| u.confirm }
  end
end
