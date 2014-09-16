class VideosController < ApplicationController
  def search
    if search_params.present?
      @videos = YoutubeService.get_videos_for(search_params[:query])
    end
  end

  private
  def search_params
    params.permit(:query)
  end
end
