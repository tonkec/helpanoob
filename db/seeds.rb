 #Fake users
10.times do |n|
  email = "example#{n+1}@email.com"
  password = "password"
  User.create(
            email: email,
            password: password,
            password_confirmation: password)
end

 #Fake groups
5.times do |n|
  title = "Group#{n+1}"
  Group.create(title: title)
end

 #Fake posts
users = User.all
10.times do |n|
  title = Faker::Lorem.words(5)
  description = Faker::Lorem.sentence(20)
  users.each {|u| u.posts.create!(description: description, title:title, group_id: rand(1..5))}
end

 #Fake comments
posts = Post.all
10.times do |n|
  content = Faker::Lorem.sentence(4)
  posts.each {|p| p.comments.create!(content: content)}
end