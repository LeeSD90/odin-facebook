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

    u2 = User.find(rand(1..User.count))
    if u != u2 && !u.get_friends.include?(u2) then
        u.send_request(u2)
        u2.accept_request(u)
    end
end

#user.friendships.create(:friend_id => User.find_by(:email => "test@example.com").id)