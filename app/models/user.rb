class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many  :friendships
  has_many  :friends, :through => :friendships, dependent: :destroy
  has_many  :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many  :inverse_friends, :through => :inverse_friendships, :source => :user

  #TODO fix show friends after sending request but before accepting it
  #TODO fix request showing on wrong side of relationship

  def get_friend_requests
    friends.where("accepted = ?", false)
  end

  def get_friends
    fs = inverse_friendships.where(accepted: true)
    result = Array.new
    fs.each do |f|
      result << User.find(f.user.id)
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
    get_friends.include?(user)
  end

end
