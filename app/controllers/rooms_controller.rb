class RoomsController < ApplicationController

    
    def index
        @room = Room.new

        @rooms = Room.public_rooms
        @users = User.all_except(current_user)
    end

    def create
        @room = Room.create(name: params["room"]["name"])
    end

    def show

        @single_room = Room.find(params[:id])
        @messages = @single_room.messages.includes(:user)

        @room = Room.new
        @rooms = Room.public_rooms

        @message = Message.new

        @counter = @single_room.counter

        @users = User.all_except(current_user)
        
        render "index"
    end
end
