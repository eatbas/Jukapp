class RecommendedVideosController < ApplicationController
  before_action :ensure_in_room

  def index
    @recommendedations  = RecommendedVideo.where(room: current_room).page(params[:page]).includes(:video)
    @recommended_videos = @recommendedations.map(&:video)
  end
end
