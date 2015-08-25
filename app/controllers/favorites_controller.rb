class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_video, only: [:create, :destroy]
  respond_to :html, :json

  def index
    favorites = Favorite.where(user_id: current_user).includes(:video)

    respond_with(favorites) do |format|
      format.html { @favorite_videos = favorites.map(&:video) }
    end
  end

  def create
    Favorite.find_or_create_by(video: @video, user: current_user)
    head :created
  end

  def destroy
    Favorite.find_by(video: @video, user: current_user).try(:destroy)
    head :ok
  end

  private
  def set_video
    @video = Video.from_youtube(params[:youtube_id], title: params[:title])
  end
end
