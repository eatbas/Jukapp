class VideosController < ApplicationController
  before_action :ensure_in_room, except: :search

  def index
    @most_played_videos = Video.order('play_count DESC').first(10)
    @last_played_videos = Video.order('played_at DESC').first(10)
  end

  def search
    if search_params.present?
      @videos = YoutubeService.get_videos_for(search_params[:query])
    end
  end

  def socket
    socket = ESHQ.open(:channel => params[:channel])

    render json: {socket: socket}
  end

  private
  def video_params
    params.require(:video).permit(:youtube_id, :title)
  end

  def search_params
    params.permit(:query)
  end
end
