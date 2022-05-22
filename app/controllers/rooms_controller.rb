class RoomsController < ApplicationController

    include RoomsHelper
    
    def index
        @room = Room.new
        @joined_rooms = current_user.joined_rooms

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
        @joined_rooms = current_user.joined_rooms
        @rooms = search_rooms

        @message = Message.new

        @counter = @single_room.counter

        @users = User.all_except(current_user)
        
        render "index"
    end

    def search
        @rooms = search_rooms
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.update('search_results',
                                  partial: 'rooms/search_results',
                                  locals: { rooms: @rooms })
            ]
          end
        end
      end

    def join
         @room = Room.find(params[:id])
         current_user.joined_rooms << @room
         redirect_to @room
    end

    def leave
        @room = Room.find(params[:id])
        current_user.joined_rooms.delete(@room)
        redirect_to rooms_path
    end
end
