FactoryGirl.define do 
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    nickname "user"
    email
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
    user
    group
  end
end