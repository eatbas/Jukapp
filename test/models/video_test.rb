require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  test "#queue sets the status to queued" do
    video = Video.create(title: "cool video", youtube_id: "fake_id")

    video.queue

    assert_equal "queued", video.reload.status
    assert video.queued_at
  end

  test "#queued returns list of queued videos in reverse queue order" do
    video = Video.create(title: "cool video", youtube_id: "fake_id")
    video.queue

    another_video = Video.create(title: "funny video", youtube_id: "another_fake_id")
    another_video.queue

    assert_equal [video, another_video], Video.queued
  end

  test "#play sets the status to played" do
    video = Video.create(title: "cool video", youtube_id: "fake_id")

    video.queue
    video.play

    assert_equal "played", video.reload.status
    assert video.played_at
  end

  test "#play raises if the video is not queued" do
    video = Video.create(title: "cool video", youtube_id: "fake_id")

    assert_raises RuntimeError do
      video.play
    end
  end

  test "#play increments the play count" do
    video = Video.create(title: "cool video", youtube_id: "fake_id")

    video.queue
    video.play

    assert_equal 1, video.reload.play_count
  end

  test "#pop returns the next song in queue" do
    video = Video.create(title: "cool video", youtube_id: "fake_id")
    video.queue

    another_video = Video.create(title: "funny video", youtube_id: "another_fake_id")
    another_video.queue

    assert_equal video, Video.pop
  end

  test "#pop doesn't raise if the queue is empty" do
    Video.queued.destroy_all

    assert_nothing_raised do
      Video.pop
    end
  end
end
