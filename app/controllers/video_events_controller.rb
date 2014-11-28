class VideoEventsController < ApplicationController
  before_action :ensure_in_room

  def index
    @queued_videos   = QueuedVideo.queue_in(current_room)
    @top_ten_videos  = VideoEvent.includes(:video).top_ten_in(current_room).map(&:video)
    @last_ten_videos = VideoEvent.includes(:video).last_ten_in(current_room).map(&:video)
  end

  def stats
    order_column = params[:sort] == "played_at" ? "played_at DESC" : "play_count DESC, played_at DESC"
    @queued_videos   = QueuedVideo.queue_in(current_room)
    @stats = VideoEvent.includes(:video).order("#{order_column}").paginate(:page => params[:page])
  end
end
