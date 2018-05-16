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

50.times do
    u = User.new()
    u.email = Faker::Internet.unique.email
    u.password = 'password'
    u.name = Faker::Name.name
    u.save!
end

#Send and accept requests
200.times do
        u = User.find(rand(1..User.count))
        u2 = User.find(rand(1..User.count))
        u.send_request(u2) unless u == u2 || u.friend?(u2)
        u2.accept_request(u)
end

#Send requests but don't accept
100.times do
    u = User.find(rand(1..User.count))
    u2 = User.find(rand(1..User.count))
    u.send_request(u2) unless u == u2 || u.friend?(u2)
end
