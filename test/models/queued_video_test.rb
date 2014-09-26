require 'test_helper'

class QueuedVideoTest < ActiveSupport::TestCase
  def setup
    @video = videos(:funny_video)
    @room = rooms(:confederation)
  end

  test "#queue creates a new queued video in the room" do
    EventStreamService.expects(:send_message_to)

    assert_difference "QueuedVideo.count" do
      QueuedVideo.queue(@video, @room)
    end

    queued_video = QueuedVideo.last
    assert_equal @video, queued_video.video
    assert_equal @room,  queued_video.room
  end

  test "#queue sends new operation to event stream" do
    EventStreamService.expects(:send_message_to).with(@room, {operation: "new"})

    QueuedVideo.queue(@video, @room)
  end

  test "#play_and_destroy destroys the queued video record" do
    assert_difference "QueuedVideo.count", -1 do
      queued_videos(:queued_funny_video).play_and_destroy
    end
  end

  test "#play_and_destroy calls play on the video" do
    Video.any_instance.expects(:play_in).with(@room)
    queued_videos(:queued_funny_video).play_and_destroy
  end

  test "#queue_in returns the queue for the passed room" do
    QueuedVideo.queue_in(@room).destroy_all

    another_video = videos(:music_video)
    QueuedVideo.queue(@video, @room)
    QueuedVideo.queue(another_video, @room)

    queue = QueuedVideo.queue_in(@room)

    assert_equal @video, queue.first.video
    assert_equal another_video, queue.second.video
  end
end
