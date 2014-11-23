class VideosController < ApplicationController
  before_action :ensure_in_room

  def search
    respond_to do |format|
      format.json { render json: {videos: search_videos.map(&:marshal_dump)} }
      format.html { @videos = search_videos }
    end
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
