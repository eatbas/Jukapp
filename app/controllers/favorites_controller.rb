class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_video, only: [:create, :destroy]

  def index
    @favorite_videos = Favorite.where(user: current_user).includes(:video).map(&:video)
  end

  def create
    Favorite.find_or_create_by(video: @video, user: current_user)
    head :ok
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
