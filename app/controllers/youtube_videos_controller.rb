class YoutubeVideosController < ApplicationController
  respond_to :json
  before_action :ensure_in_room

  def search
    if params[:query]
      results = YoutubeVideo.search(params[:query])
      # preload videos
      respond_with(results.as_json(current_room: current_room))
    end
  end
end
