class Room < ApplicationRecord

    validates :name, presence: true ,uniqueness: true
    scope :public_rooms, -> { where(is_private: false) }
    after_create_commit { broadcast_append_to 'rooms' }
end
