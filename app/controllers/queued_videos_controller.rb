class QueuedVideosController < ApplicationController
  before_action :ensure_in_room
  respond_to :html, :json

  def queue
    room = current_room
    QueuedVideo.queue(Video.from_youtube(params[:youtube_id], title: params[:title]), room)

    respond_with({}, location: search_videos_path) do |format|
      format.html { redirect_to search_videos_path }
    end
  end

  def play
    @current = fetch_next_video

    respond_to do |format|
      format.json { render json: {video: @current} }
      format.html do
        @queued_videos = QueuedVideo.queue_in(current_room)
      end
    end
  end

  def next
    EventStreamService.send_message_to(current_room, {operation: "next"})
    redirect_to :back, notice: "Skipped to the next video"
  end

  def index
    queued_videos = QueuedVideo.queue_in(current_room)

    respond_with(queued_videos.includes(video: :video_events)) do |format|
      format.html { render partial: "shared/queued_videos_table", locals: { queued_videos: queued_videos } }
    end
  end

  def destroy
    QueuedVideo.find(params[:id]).try(:destroy)
    EventStreamService.send_message_to(current_room, {operation: "delete"})

    render json: {}
  end

  private
  def fetch_next_video
    if queued_video = QueuedVideo.next_in(current_room).presence
      EventStreamService.send_message_to(current_room, {operation: "play"})
      queued_video.play_and_destroy
    elsif video = Video.from_reddit(params[:r]) || Video.from_youtube_list(params[:list])
      video.play_in(current_room)
    end
  end
end
