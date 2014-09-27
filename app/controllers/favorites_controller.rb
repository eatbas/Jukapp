class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorite_videos = Favorite.where(user: current_user).includes(:video).map(&:video)
  end

  def create
    new_video_id = unless params[:video_id]
      # from search page
      Video.create_with(title: params["title"]).find_or_create_by(youtube_id: params["youtube_id"]).id
    end
    Favorite.find_or_create_by(video_id: params[:video_id] || new_video_id, user: current_user)
    head :ok
  end

  def destroy
    Favorite.find_by(video_id: params[:video_id], user: current_user).try(:destroy)
    head :ok
  end
end
