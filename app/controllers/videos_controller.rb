class VideosController < ApplicationController
  respond_to :html, :json
  before_action :ensure_in_room

  before_action :fetch_video, only: [:queue, :dequeue, :prioritize, :deprioritize, :pause, :continue]

  def play
    @queued_videos = current_room.videos.queued.to_a

    if next_video = @queued_videos.first
      if next_video.play && next_video.save
        stream :play
        @current = next_video.youtube_video
      end
    end

    respond_with({video: @current})
  end

  def create
    video = current_room.videos.new
    video.initialize_from_youtube(video_params[:youtube_id])
    video.queue(user: current_user)
    video.save

    stream :new
    head :created
  end

  def queue
    @video.queue(user: current_user)
    @video.save

    stream :new
    head :ok
  end

  def dequeue
    @video.dequeue
    @video.save

    stream :new # change this to :change
    head :ok
  end

  def prioritize
    @video.prioritize
    @video.save

    stream :new # change this to :change
    head :ok
  end

  def deprioritize
    @video.deprioritize
    @video.save

    stream :new # change this to :change
    head :ok
  end

  def pause
    @video.pause
    @video.save

    stream :player_state_change
    head :ok
  end

  def continue
    @video.continue
    @video.save

    stream :player_state_change
    head :ok
  end

  def index
    top_videos = current_room.videos#.top_videos
    response = {
      now_playing: current_room.videos.now_playing
    }
    respond_with(response)
  end

  # OLD STUFF

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
