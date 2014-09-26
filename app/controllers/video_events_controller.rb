class VideoEventsController < ApplicationController
  before_action :ensure_in_room

  def index
    @top_ten = VideoEvent.top_ten_in(current_room)
    @last_ten = VideoEvent.last_ten_in(current_room)
  end
end
