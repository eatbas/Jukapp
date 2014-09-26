require 'test_helper'

class VideoEventTest < ActiveSupport::TestCase
  def setup
    @room = rooms(:confederation)
    @video = videos(:funny_video)
  end

  test "#play creates a new video event if video has never played in room" do
    VideoEvent.find_by(video: @video, room: @room).destroy

    assert_difference "VideoEvent.count" do
      VideoEvent.play(@video, @room)
    end

    event = VideoEvent.last
    assert_equal @video, event.video
    assert_equal @room, event.room
  end

  test "#play does not create a new video event if video has played in room before" do
    VideoEvent.play(@video, @room)
    assert_no_difference "VideoEvent.count" do
      VideoEvent.play(@video, @room)
    end
  end

  test "#play increments the play count and sets played_at" do
    event = VideoEvent.find_by(video: @video, room: @room)
    assert_difference "event.reload.play_count", 2 do
      2.times { VideoEvent.play(@video, @room) }
    end
  end
end
