class VideosController < ApplicationController
  respond_to :html, :json
  before_action :ensure_in_room

  before_action :fetch_video, only: :queue

  def queue
    @video.queue(user: current_user)

    stream('new')
    head :ok
  end

  def create
    video = current_room.videos.new
    video.initialize_from_youtube(video_params[:youtube_id])
    video.save!

    stream('new')
    head :created
  end

  def play
    video = current_room.videos.queued.first
    video.play

    queued_video = QueuedVideo.next_in(current_room).presence
    EventStreamService.send_message_to(current_room, {operation: "play"})
    queued_video.play_and_destroy

    @current = fetch_next_video

    respond_to do |format|
      format.json { render json: {video: @current} }
      format.html do
        @queued_videos = QueuedVideo.queue_in(current_room)
      end
    end
  end

  ## OLD STUFF

  def index
    videos = VideoEvent.includes(:video).top_ten_in(current_room).map(&:video)
    respond_with(videos)
  end

  def search
    @videos = search_videos

    respond_with(@videos)
  end

  def ajax_search
    render partial: "shared/videos_table", locals: { videos: search_videos }
  end

  private

  def fetch_video
    @video = current_room.videos.find(id)
  end

  def search_videos
    if search_params.present?
      YoutubeService.get_videos_for(search_params[:query])
    end
  end

  def video_params
    params.require(:video).permit(:youtube_id)
  end

  def search_params
    params.permit(:query)
  end
end
