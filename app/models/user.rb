class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many  :friendships
  has_many  :friends, :through => :friendships, dependent: :destroy
  has_many  :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many  :inverse_friends, :through => :inverse_friendships, :source => :user

  has_many  :posts, foreign_key: "author_id", dependent:  :destroy
  has_many  :comments
  has_many  :likes

  after_create  :send_welcome_mail

  def post_feed
    Post.where("author_id = ? OR author_id IN (?)", id, get_friends.map{|f| f.id })
  end

  def get_friend_requests
    friends.where("accepted = ?", false)
  end

  def get_friends
    fs = friendships.where(accepted: true)
    result = Array.new
    fs.each do |f|
      result << User.find(f.friend_id) if f.inverse.accepted
    end
    return result
  end

  def send_request(user)
    friendships.create(friend_id: user.id, accepted: true)
  end

  def accept_request(user)
    friendships.where(friend_id: user.id).update(accepted: true)
  end

  def pending_request(user)
    friendships.where(friend_id: user.id, accepted: false).first
  end

  def friend?(user)
    get_friends.include?(user) || user.get_friend_requests.include?(self) || self.get_friend_requests.include?(user)
  end

  def send_welcome_mail
    UserMailer.welcome_email(self).deliver
  end

end
