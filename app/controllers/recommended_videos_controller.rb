class RecommendedVideosController < ApplicationController
  before_action :ensure_in_room

  def index
    @recommended_videos = current_room.recommended_videos.includes(:video).map(&:video)
  end
end
