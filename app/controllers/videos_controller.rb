class VideosController < ApplicationController
  def search
    if search_params.present?
      @videos = YoutubeService.get_videos_for(search_params[:query])
    end
  end

  def create
    @video = Video.create_with(title: video_params["title"]).find_or_create_by(youtube_id: video_params["youtube_id"])
    @video.queue

    redirect_to search_videos_path
  end

  def play
    @current = Video.pop
  end

  def next
    ESHQ.send( channel: "video-queue", data: {operation: "next"}.to_json )

    redirect_to search_videos_path
  end

  def open_socket
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
