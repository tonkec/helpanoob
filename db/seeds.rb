 #Fake users
10.times do |n|
  email = "example#{n+1}@email.com"
  password = "password"
  avatar = Faker::Avatar.image("http://images.all-free-download.com/images/graphiclarge/daisy_pollen_flower_220533.jpg")
  name = Faker::Name.name
  User.create!(
            nickname: name,
            avatar: avatar,
            email: email,
            password: password,
            password_confirmation: password)
end


#Fake posts
user = User.last
10.times do |n|
  title = Faker::Lorem.sentence(20)
  description = Faker::Lorem.sentence(80)
  content = Faker::Lorem.sentence(20)
  user.posts.create!(description: description, title:title)
end

 #Fake comments
posts = Post.all
2.times do |n|
  #content = Faker::Lorem.sentence(20)
  posts.each  do |p| 
    p.tag_list.add("rails", "jquery", "javascript", "php", "ruby") 
    p.save
  end
end