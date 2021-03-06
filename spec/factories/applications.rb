FactoryBot.define do
  factory :application, class: Doorkeeper::Application do
    sequence(:name) { |n| "name#{n}" }
    sequence(:uid) { |n| "uid#{n}" }
    sequence(:secret) { |n| "secret#{n}" }
    redirect_uri 'urn:ietf:wg:oauth:2.0:oob'
    association :owner, factory: :user
  end
end
