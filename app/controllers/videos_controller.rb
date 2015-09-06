class VideosController < ApplicationController
  respond_to :json
  respond_to :html, only: :jukebox
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

  def jukebox
    respond_with(@queued_videos = current_room.videos.queued)
  end

  def play
    if next_video = current_room.videos.queued.to_a.shift # removes first item
      if next_video.play && next_video.save
        stream :play
        current = next_video
      end
    end

    respond_with(current)
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
    @video = current_room.videos.find_or_create_by(youtube_id: params[:youtube_id])
  end
end
