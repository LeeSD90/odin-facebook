user = User.new()
user.email = 'test@example.com'
user.password = 'password'
user.name = 'Joe'
user.save!

user = User.new()
user.email = 'test2@example.com'
user.password = 'password'
user.name = 'Bob'
user.save!

# Users
150.times do
    u = User.new()
    u.email = Faker::Internet.unique.email
    u.password = 'password'
    u.name = Faker::Name.name
    u.save!
end

# Send and accept requests
300.times do
        u = User.find(rand(1..User.count))
        u2 = User.find(rand(1..User.count))
        u.send_request(u2) unless u == u2 || u.friend?(u2)
        u2.accept_request(u)
end

# Send requests but don't accept
200.times do
    u = User.find(rand(1..User.count))
    u2 = User.find(rand(1..User.count))
    u.send_request(u2) unless u == u2 || u.friend?(u2)
end

# Make some posts
800.times do
    u = User.find(rand(1..User.count))
    u.posts.create(:content => Faker::Lorem.sentence(rand(1..30)))
end

# Comments
2000.times do
    p = Post.find(rand(1..Post.count))
    u = User.find(rand(1..User.count))
    u.comments.create(:post_id => p.id, :content => Faker::Lorem.sentence(rand(2..10)))
end

# Likes
5000.times do
    p = Post.find(rand(1..Post.count))
    u = User.find(rand(1..User.count))
    p.likes.create(:user_id => u.id) unless p.likes.where(user_id: u.id).first
end
