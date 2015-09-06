class FavoritesController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :json

  def index
    favorites = Favorite.where(user_id: current_user).includes(:youtube_video)

    respond_with(favorites) do |format|
      format.html { @favorite_videos = favorites.map(&:youtube_video) }
    end
  end

  def create
    current_user.favorites.create(youtube_id: params[:youtube_id])
    head :created
  end

  def destroy
    current_user.favorites.find_by(youtube_id: params[:youtube_id]).destroy
    head :ok
  end
end
