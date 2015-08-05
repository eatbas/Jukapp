class QueuedVideosController < ApplicationController
  # before_action :ensure_in_room

  def queue
    room = current_room || Room.find_by(18) || Room.first

    QueuedVideo.queue(Video.from_youtube(params[:youtube_id], title: params[:title]), room)

    redirect_to search_videos_path
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

  def socket
    socket = ESHQ.open(:channel => params[:channel])
    render json: {socket: socket}
  end

  def index
    render partial: "shared/queued_videos_table", locals: { queued_videos: QueuedVideo.queue_in(current_room) }
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
