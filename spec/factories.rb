FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "User-#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }    

    password "password"
    password_confirmation "password"
    experience 20
    avatar  { File.open("#{Rails.root}/spec/fixtures/files/sweal.jpg") }
  end

  factory :post do
    description Faker::Lorem.characters(101)
    sequence(:title) { |n| Faker::Lorem.paragraph(4) + "-#{n}" }
    tag_list "ruby"
    user
  end

  factory :skill do
    name "ruby"
    strength Faker::Number.between(0, 100)
    user
  end

  factory :comment do
    sequence(:content) { |n| Faker::Lorem.paragraph(4) + "-#{n}" }
    post
  end
end