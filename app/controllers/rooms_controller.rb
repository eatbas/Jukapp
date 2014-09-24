class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :join]

  def index
    @rooms = Room.all
  end

  def show
    @queued_videos = QueuedVideo.queue_in(@room)
  end

  def create
    @room = Room.create(room_params)
    join_room(@room)

    redirect_to rooms_path
  end

  def join
    join_room(@room)
    redirect_to rooms_path, notice: "Joined"
  end

  def leave
    session[:current_room_id] = nil
    redirect_to rooms_path
  end

  private
  def room_params
    params.require(:room).permit(:name)
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def join_room(room)
    session[:current_room_id] = room.try(:id)
  end
end
