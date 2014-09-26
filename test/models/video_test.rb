require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  test "#play_in sends play event with room" do
    video = Video.create(title: "cool video", youtube_id: "fake_id")
    room = rooms(:confederation)
    VideoEvent.expects(:play).with(video, room)

    video.play_in(room)
  end
end
