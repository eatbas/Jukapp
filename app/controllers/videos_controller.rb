class VideosController < ApplicationController
  before_action :ensure_in_room

  def search
    if search_params.present?
      @videos = YoutubeService.get_videos_for(search_params[:query])
    end
  end

  private
  def video_params
    params.require(:video).permit(:youtube_id, :title)
  end

  def search_params
    params.permit(:query)
  end
end
