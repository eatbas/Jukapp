class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :join]

  def index
    @rooms = Room.all
  end

  def show

  end

  def create
    @room = Room.create(room_params)

    redirect_to rooms_path
  end

  def join
    session[:current_room_id] = @room.try(:id)
    redirect_to rooms_path
  end

  def leave
    session[:current_room_id] = nil
    redirect_to rooms_path
  end

  def socket
    socket = ESHQ.open(:channel => params[:channel])
    render json: {socket: socket}
  end

  private
  def room_params
    params.require(:room).permit(:name)
  end

  def set_room
    @room = Room.find(params[:id])
  end
end
