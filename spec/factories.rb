FactoryGirl.define do 
  factory :user do
    nickname "user"
    email "factory_1@example.com"
    password "password"
    password_confirmation "password"
    avatar  { File.open("#{Rails.root}/spec/fixtures/files/sweal.jpg") } 
  end

  factory :group do
    title "First Group"
  end

  factory :post do
    description Faker::Lorem.sentence(3)
    title Faker::Lorem.words(3)
    association :user
    association :group
  end
end