class VideosController < ApplicationController
  before_action :ensure_in_room
  respond_to :html, :json

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
  def search_videos
    if search_params.present?
      YoutubeService.get_videos_for(search_params[:query])
    end
  end

  def video_params
    params.require(:video).permit(:youtube_id, :title)
  end

  def search_params
    params.permit(:query)
  end
end
