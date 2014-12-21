class VideoEventsController < ApplicationController
  before_action :ensure_in_room

  def index
  end

  def recents
    recents = VideoEvent.where(room: current_room).includes(:video).order("played_at DESC").paginate(:page => params[:page])
    render_video_rows(recents)
  end

  def popular
    popular = VideoEvent.where(room: current_room).includes(:video).order("play_count DESC").paginate(:page => params[:page])
    render_video_rows(popular)
  end
end
