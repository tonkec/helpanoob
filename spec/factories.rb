FactoryGirl.define do 
  factory :user do
    username "user"
    sequence(:email) { |n| "test#{n}@example.com" }    
    password "password"
    password_confirmation "password"
    avatar  { File.open("#{Rails.root}/spec/fixtures/files/sweal.jpg") } 
  end

  factory :post do
    description Faker::Lorem.characters(101)
    title Faker::Lorem.words(3)
    tag_list Faker::Lorem.words(3)
    user
  end

  factory :skill do
    name Faker::Lorem.words(1)
    strength Faker::Number.between(0, 100)
    user
  end

  factory :comment do
    content Faker::Lorem.sentence(3)
    post
  end
end