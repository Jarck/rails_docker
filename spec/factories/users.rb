FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "test#{n}" }
    sequence(:login) { |n| "test#{n}" }
    sequence(:email) { |n| "test#{n}@test.com" }
    password 'password'
    password_confirmation 'password'
  end
end
