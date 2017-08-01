FactoryGirl.define do
  factory :node do
    sequence(:name) { |n| "name#{n}" }
    sequence(:title) { |n| "title#{n}" }
    publish 1

    factory :private do
      name 'private'
      publish 0
    end
  end
end
