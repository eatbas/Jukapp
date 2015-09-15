class FavoritesController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def index
    ## TODO needs join query
    favorites = Favorite.where(user_id: current_user).includes(:youtube_video)
    respond_with(favorites.as_json(current_room: current_room))
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
