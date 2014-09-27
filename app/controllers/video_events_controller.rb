class VideoEventsController < ApplicationController
  before_action :ensure_in_room

  def index
    @top_ten_videos  = VideoEvent.includes(:video).top_ten_in(current_room).map(&:video)
    @last_ten_videos = VideoEvent.includes(:video).last_ten_in(current_room).map(&:video)
  end
end
