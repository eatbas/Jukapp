class VideosController < ApplicationController
  respond_to :json
  respond_to :html, only: [:play, :play_new]
  before_action :ensure_in_room

  before_action :fetch_video, only: [:queue, :dequeue, :prioritize, :deprioritize, :pause, :continue]

  def index
    videos = case params[:type]
    when 'playlist'
      current_room.videos.where(status: ['queued', 'prioritized', 'playing', 'paused']).limit(11)
    when 'latest'
      current_room.videos.not_on_player.order(played_at: :desc).paginate(page: params[:page])
    else
      current_room.videos.order(play_count: :desc, played_at: :desc).paginate(page: params[:page])
    end

    respond_with(videos)
  end

  def play_new
    @queued_videos = current_room.videos.queued.to_a

    if next_video = @queued_videos.shift # removes first item
      if next_video.play && next_video.save
        stream :play
        @current = next_video.youtube_video
      end
    end

    respond_with(@current)
  end

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

    stream :playlist_change
    head :ok
  end

  def prioritize
    @video.prioritize(user: current_user)
    @video.save

    stream :playlist_change
    head :ok
  end

  def deprioritize
    @video.deprioritize
    @video.save

    stream :playlist_change
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

  private

  def fetch_video
    @video = current_room.videos.find(id)
  end

  def video_params
    params.require(:video).permit(:youtube_id)
  end
end
