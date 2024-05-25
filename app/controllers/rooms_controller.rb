class RoomsController < ApplicationController
  include RoomsHelper

  def new
    @room = Room.new
  end

  def index
    @joined_rooms = current_user.joined_rooms
    @joinable_rooms =  current_user.joinable_rooms

    render 'index', status: :ok
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      render 'show', status: :created
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  def show
    @room = Room.includes(messages: :user).find(params[:id])
    render 'show', status: :ok
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

  private

  def room_params
    params.require(:room).permit(:name, is_private: false)
  end
end
