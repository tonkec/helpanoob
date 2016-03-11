FactoryGirl.define do
  factory :user do
    nickname "user"
    email "factory_1@example.com"
    password "password"
    password_confirmation "password"
    avatar  Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/sweal.jpg'), 'jpg')
  end
end