require 'test_helper'

class QueuedVideoTest < ActiveSupport::TestCase
  test "#queue creates a new queued video in the room" do
    video = videos(:funny_video)
    room = rooms(:confederation)

    ESHQ.expects(:send)

    assert_difference "QueuedVideo.count" do
      QueuedVideo.queue(video, room)
    end

    queued_video = QueuedVideo.last
    assert_equal video, queued_video.video
    assert_equal room,  queued_video.room
  end

  test "#queue sends new operation to event stream" do
    video = videos(:funny_video)
    room = rooms(:confederation)

    ESHQ.expects(:send).with(channel: "queue-#{room.id}", :data => {operation: 'new'}.to_json )

    QueuedVideo.queue(video, room)
  end

  test "#play_and_destroy destroys the queued video record" do
    assert_difference "QueuedVideo.count", -1 do
      queued_videos(:queued_funny_video).play_and_destroy
    end
  end

  test "#play_and_destroy calls play on the video" do
    Video.any_instance.expects(:play)
    queued_videos(:queued_funny_video).play_and_destroy
  end
end
