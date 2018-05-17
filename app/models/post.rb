class Post < ApplicationRecord
    belongs_to  :author, class_name: "User"
    has_many    :comments
    
    validates   :author_id, presence: true
    validates   :content, presence: true, length: { maximum: 3000 }
end
