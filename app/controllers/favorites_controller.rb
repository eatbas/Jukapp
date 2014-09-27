class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorite_videos = Favorite.where(user: current_user).includes(:video).map(&:video)
  end

  def create
    Favorite.find_or_create_by(video_id: params[:video_id], user: current_user)
    head :ok
  end

  def destroy
    Favorite.find(params[:id]).try(:destroy)
    head :ok
  end
end
