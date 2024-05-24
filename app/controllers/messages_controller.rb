class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    unless @message.save
      render json: { errors: @message.errors }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    premitted_data = params.require(:message).permit(:content, :room_id)
    room = Room.find(premitted_data[:room_id])
    premitted_data.merge!(number: room.messages_count, user_id: current_user.id)
  end
end
