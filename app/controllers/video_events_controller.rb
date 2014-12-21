class VideoEventsController < ApplicationController
  before_action :ensure_in_room

  def index
    @recents   = VideoEvent.where(room: current_room).includes(:video).order("played_at DESC").paginate(:page => params[:page])
    @populars  = VideoEvent.where(room: current_room).includes(:video).order("play_count DESC").paginate(:page => params[:page])
    @favorites = current_user ? Favorite.where(user: current_user).includes(:video).map(&:video) : []
  end
end
