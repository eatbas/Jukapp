require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  test "#play increments the play count" do
    video = Video.create(title: "cool video", youtube_id: "fake_id")

    video.queue
    video.play

    assert_equal 1, video.reload.play_count
  end
end
