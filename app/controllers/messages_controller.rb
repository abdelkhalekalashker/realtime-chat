class MessagesController < ApplicationController
  
  def create
    @current_user = current_user
    @room = Room.find(params[:room_id])#.includes([:user])
    @room.update(counter: @room.counter + 1)
    @message = @current_user.messages.create(number: @room.counter ,content: message_params[:content],room_id: params[:room_id])#.includes([:user])

  end


  private
  def message_params
    params.require(:message).permit(:content)
  end
  

end
