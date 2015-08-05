class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :join]
  before_action :authenticate_user!, only: :create
  respond_to :html, :json

  def index
    respond_with Room.all
  end

  def show
    @queued_videos = QueuedVideo.queue_in(@room)
  end

  def create
    @room = Room.new(room_params)
    @room.owner = current_user
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

    respond_with(@room) do |format|
      format.html do
        redirect_to settings_path, notice: "Joined"
      end
    end
  end

  def leave
    session[:current_room_id] = nil
    redirect_to settings_path
  end

  def destroy
    Room.find(params[:id]).try(:destroy)
    redirect_to :back
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
