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

#user.friendships.create(:friend_id => User.find_by(:email => "test@example.com").id)