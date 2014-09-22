class QueuedVideosController < ApplicationController
  before_action :ensure_in_room

  def queue
    video = Video.create_with(title: video_params["title"]).find_or_create_by(youtube_id: video_params["youtube_id"])
    QueuedVideo.queue(video, current_room)

    redirect_to search_videos_path
  end

  def play
    next_in_queue = QueuedVideo.next_in(current_room)
    # @current = next_in_queue.video if next_in_queue.try(:play_and_destroy)
    @current = next_in_queue.video if next_in_queue.present?
  end

  def next
    EventStreamService.send_message_to(current_room, {operation: "next"})
    redirect_to search_videos_path
  end

  def socket
    socket = ESHQ.open(:channel => params[:channel])
    render json: {socket: socket}
  end

  private
  def video_params
    params.require(:video).permit(:youtube_id, :title)
  end
end
