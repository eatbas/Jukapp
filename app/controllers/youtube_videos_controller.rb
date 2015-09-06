class YoutubeVideosController < ApplicationController
  respond_to :json
  before_action :ensure_in_room

  def search
    if params[:query]
      results = YoutubeVideo.search(params[:query])
      respond_with(results)
    end
  end
end
