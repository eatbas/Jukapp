class QueuedVideosController < ApplicationController
  before_action :ensure_in_room

  def queue
    QueuedVideo.queue(Video.from_youtube(params[:youtube_id], title: params[:title]), current_room)

    flash[:notice] = "Added new video"
    render nothing: true
  end

  def play
    @current = fetch_next_video

    respond_to do |format|
      format.json { render json: {video: @current} }
      format.html do
        @queued_videos = QueuedVideo.queue_in(current_room)
        @recents       = VideoEvent.where(room: current_room).includes(:video).order("played_at DESC").paginate(:page => params[:page])
        @populars      = VideoEvent.where(room: current_room).includes(:video).order("play_count DESC").paginate(:page => params[:page])
      end
    end
  end

  def next
    EventStreamService.send_message_to(current_room, "next")
    redirect_to :back, notice: "Skipped to the next video"
  end

  def socket
    socket = ESHQ.open(:channel => params[:channel])
    render json: {socket: socket}
  end

  def index
    render json: QueuedVideo.queue_in(current_room).as_json(only: [:id, :video])
  end

  def destroy
    QueuedVideo.find(params[:id]).try(:destroy)
    EventStreamService.send_message_to(current_room, "delete")

    flash[:notice] = "Deleted a video"
    render json: {}
  end

  private
  def fetch_next_video
    if queued_video = QueuedVideo.next_in(current_room).presence
      EventStreamService.send_message_to(current_room, "play")
      queued_video.play_and_destroy
    elsif video = Video.from_reddit(params[:r]) || Video.from_youtube_list(params[:list])
      video.play_in(current_room)
    end
  end
end
