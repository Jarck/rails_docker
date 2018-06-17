FactoryBot.define do
  factory :role do
    factory :admin do
      name 'admin'
    end

    factory :member do
      name 'member'
    end
  end
end
