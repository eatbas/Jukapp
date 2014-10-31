class QueuedVideosController < ApplicationController
  before_action :ensure_in_room

  def queue
    QueuedVideo.queue(Video.from_youtube(params[:youtube_id], title: params[:title]), current_room)

    redirect_to search_videos_path
  end

  def play
    next_in_queue = QueuedVideo.next_in(current_room)

    @current = next_in_queue.try(:play_and_destroy) || Video.from_reddit(params[:r]).try(:play_in, current_room)
    @queued_videos = QueuedVideo.includes(:video).queue_in(current_room).map(&:video)
  end

  def next
    EventStreamService.send_message_to(current_room, {operation: "next"})
    redirect_to search_videos_path, notice: "Skipped to the next video"
  end

  def socket
    socket = ESHQ.open(:channel => params[:channel])
    render json: {socket: socket}
  end
end
