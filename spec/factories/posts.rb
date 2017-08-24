FactoryGirl.define do
  factory :post do
    body 'Lorem ipsum'
    association :user, factory: :user
  end
end
