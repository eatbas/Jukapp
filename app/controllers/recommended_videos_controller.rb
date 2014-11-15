class RecommendedVideosController < ApplicationController
  before_action :ensure_in_room

  def index
    @queued_videos      = QueuedVideo.queue_in(current_room)
    @recommendedations  = RecommendedVideo.where(room: current_room).page(params[:page]).includes(:video)
    @recommended_videos = @recommendedations.map(&:video)
  end
end
