FactoryGirl.define do
  factory :picture do
    association :user
    image Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'factories', 'jarck.png'), 'image/png')
  end
end
