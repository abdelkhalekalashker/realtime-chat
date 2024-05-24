class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room, counter_cache: true
  after_create_commit { broadcast_append_to room }
  before_create :confirm_participant


  def confirm_participant
    if room.is_private
      is_participant = Participant.where(user_id: user_id, room_id: room_id).first
      throw :abort unless is_participant
    end
  end
end
