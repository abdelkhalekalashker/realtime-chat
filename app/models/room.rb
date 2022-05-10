class Room < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    scoope :public_rooms, -> { where(is_private: false) }
end
