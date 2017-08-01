FactoryGirl.define do
  factory :topic do
    association :user
    association :node

    sequence(:title) { |n| "title#{n}" }
    sequence(:body)  { |n| "body#{n}" }

    factory :text_body do
      body 'test'
    end

    factory :valid_html_body do
      body '<p>test</p>'
    end

    factory :invalid_html_body do
      body '<script>alert("test");</script>'
    end

  end
end
