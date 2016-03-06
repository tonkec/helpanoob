FactoryGirl.define do
  factory :user do
    nickname "user"
    email "factory@example.com"
    password "password"
    password_confirmation "password"
    avatar  File.new("#{Rails.root}/spec/fixtures/files/sweal.jpg")
  end
end