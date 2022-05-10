class MessagesController < ApplicationController
  def create
    @current_user = current_user
    @message = @current_user.messages.create(content: message_params[:content],room_id: params[:room_id])
  end

  private
  def message_params
    params.require(:message).permit(:content)
  end
  

end
