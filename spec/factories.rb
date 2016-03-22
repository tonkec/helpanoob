FactoryGirl.define do 
#  sequence :email do |n|
 #   "person#{n}@example.com"
 # end

  factory :user do
    username "user"
    sequence(:email) { |n| "test#{n}@example.com" }    
    password "password"
    password_confirmation "password"
    avatar  { File.open("#{Rails.root}/spec/fixtures/files/sweal.jpg") } 
  end

  factory :post do
    description Faker::Lorem.sentence(3)
    title Faker::Lorem.words(3)
    user
  end

  factory :comment do
    content Faker::Lorem.sentence(3)
    post
  end
end