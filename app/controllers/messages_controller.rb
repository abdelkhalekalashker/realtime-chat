class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    unless @message.save
      render json: { errors: @message.errors }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :room_id).merge(user_id: current_user.id)
  end
end
