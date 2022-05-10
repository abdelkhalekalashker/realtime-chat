class RoomsController < ApplicationController
  def index
    @rooms = Room.public_rooms
    @users = User.except_current_user(current_user)
    
  end
end
