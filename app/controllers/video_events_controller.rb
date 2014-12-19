class VideoEventsController < ApplicationController
  before_action :ensure_in_room

  def index
    @recents       = VideoEvent.where(room: current_room).includes(:video).order("played_at DESC").paginate(:page => params[:page])
    @populars      = VideoEvent.where(room: current_room).includes(:video).order("play_count DESC").paginate(:page => params[:page])
  end
end
