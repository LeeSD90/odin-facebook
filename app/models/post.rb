class Post < ApplicationRecord
    belongs_to  :author, class_name: "User"
    has_many    :comments, dependent: :destroy
    has_many    :likes, dependent: :destroy
    
    validates   :author_id, presence: true
    validates   :content, presence: true, length: { maximum: 3000 }

    default_scope -> {order(created_at: :desc)}

    def liked_by?(user)
        likes.where(user_id: user.id).first
    end
end
