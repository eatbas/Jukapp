class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def create
    @room = Room.create(room_params)

    redirect_to rooms_path
  end

  def join
    room = Room.find(params[:id])
    session[:current_room_id] = room.try(:id)

    redirect_to rooms_path
  end

  def leave
    session[:current_room_id] = nil
    redirect_to rooms_path
  end

  private
  def room_params
    params.require(:room).permit(:name)
  end
end
