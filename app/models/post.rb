class Post < ApplicationRecord
    belongs_to  :author, class_name: "User"
    has_many    :comments
    has_many    :likes
    
    validates   :author_id, presence: true
    validates   :content, presence: true, length: { maximum: 3000 }

    def liked_by?(user)
        likes.where(user_id: user.id).first
    end
end
