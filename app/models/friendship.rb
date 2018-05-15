class Friendship < ApplicationRecord
    belongs_to  :user
    belongs_to  :friend, :class_name => "User"

    after_create    :create_inverse, unless: :has_inverse?
    after_destroy   :destroy_inverses, if: :has_inverse?
    after_commit    :update_inverse

    validates   :user_id, presence: true
    validates   :friend_id, presence: true

    private

        def create_inverse
            self.class.create(inverse_match_options)
        end

        def destroy_inverse
            self.class.where(inverse_match_options).destroy_all
        end

        def update_inverse
            self.class.where(inverse_match_options).update(accepted: self.accepted)
        end

        def has_inverse?
            self.class.exists?(inverse_match_options)
        end

        def inverse_match_options
            { user_id: friend_id, friend_id: user_id }
        end
end
