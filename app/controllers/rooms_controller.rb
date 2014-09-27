class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :join]

  def show
    @queued_videos = QueuedVideo.queue_in(@room)
  end

  def create
    @room = Room.new(room_params)
    success = @room.save
    if success
      join_room(@room)
      redirect_to settings_path
    else
      render 'settings/index'
    end
  end

  def join
    join_room(@room)
    redirect_to settings_path, notice: "Joined"
  end

  def leave
    session[:current_room_id] = nil
    redirect_to settings_path
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
