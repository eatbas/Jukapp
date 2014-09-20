class QueuedVideosController < ApplicationController
  before_action :ensure_in_room

  def queue
    video = Video.create_with(title: video_params["title"]).find_or_create_by(youtube_id: video_params["youtube_id"])
    QueuedVideo.queue(video, current_room)

    redirect_to search_videos_path
  end

  def play
    queued_video = QueuedVideo.next_in(current_room)
    @current = queued_video.try(:play)
  end

  private
  def video_params
    params.require(:video).permit(:youtube_id, :title)
  end
end
