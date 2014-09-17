require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  test "#queue sets the status to queued" do
    video = Video.create(title: "cool video", youtube_id: "fake_id")

    video.queue

    assert_equal "queued", video.reload.status
    assert video.queued_at
  end

  test "#queued returns list of queued videos" do
    video = Video.create(title: "cool video", youtube_id: "fake_id")
    video.queue

    assert_equal [video], Video.queued
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
end
