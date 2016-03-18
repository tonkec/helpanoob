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

 #Fake groups
5.times do |n|
  title = "Group#{n+1}"
  Group.create!(title: title)
end

 #Fake posts
users = User.all
4.times do |n|
  title = Faker::Lorem.sentence(20)
  description = Faker::Lorem.sentence(80)
  content = Faker::Lorem.sentence(20)
  users.each {|u| u.posts.create!(description: description, title:title, group_id: rand(1..5))}
end

 #Fake comments
posts = Post.all
10.times do |n|
  content = Faker::Lorem.sentence(20)
  posts.each {|p| p.comments.create!(content: content, user_id: 4)}
end