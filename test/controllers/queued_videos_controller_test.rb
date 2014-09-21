require 'test_helper'

class QueuedVideosControllerTest < ActionController::TestCase

  def setup
    @room = rooms(:confederation)
    join_room @room
  end

  test "POST to :queue creates a new queued video" do
    video = videos(:funny_video)
    QueuedVideo.expects(:queue).with(video, @room)
    post :queue, video: {youtube_id: video.youtube_id, title: video.title}
  end

  test "POST to :queue creates a new video with title and youtube id" do
    assert_difference 'Video.count' do
      post :queue, video: {youtube_id: "fake_id", title: "funny video"}
    end

    video = Video.last
    assert_equal "fake_id", video.youtube_id
    assert_equal "funny video", video.title
    assert_redirected_to search_videos_path
  end

  test "POST to :queue doesn't create new video if youtube_id exists" do
    post :queue, video: {youtube_id: "fake_id", title: "funny video"}

    assert_no_difference 'Video.count' do
      post :queue, video: {youtube_id: "fake_id", title: "funny video"}
    end

    assert_redirected_to search_videos_path
  end

  test "GET to :play sets the current song to the next video in the room" do
    next_in_queue = queued_videos(:queued_funny_video)
    QueuedVideo.expects(:next_in).with(@room).returns(next_in_queue)

    get :play

    current = assigns(:current)
    assert_equal next_in_queue.video, current
  end

  test "GET to :play calls play_and_destroy on the queued video" do
    next_in_queue = queued_videos(:queued_funny_video)
    QueuedVideo.expects(:next_in).with(@room).returns(next_in_queue)
    QueuedVideo.any_instance.expects(:play_and_destroy)

    get :play
  end

  test "GET to :next sends next operation to event stream" do
    EventStreamService.expects(:send_message_to).with(@room, {operation: "next"})

    get :next
    assert_redirected_to search_videos_path
  end

  test "POST to :socket opens a new socket with the channel parameter" do
    ESHQ.expects(:open).with(channel: "fake_channel").returns('socket')
    post :socket, channel: "fake_channel"

    assert_equal "socket", JSON.parse(response.body)['socket']
  end
end
