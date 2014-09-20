require 'test_helper'

class VideosControllerTest < ActionController::TestCase
  test "GET to :search without any params doesn't call YoutubeService" do
    YoutubeService.expects(:get_videos_for).never
    get :search
  end

  test "GET to :search with query calls YoutubeService" do
    YoutubeService.expects(:get_videos_for).with("my favorite video")
    get :search, query: "my favorite video"
  end

  test "POST to :create creates a new video with title and youtube id" do
    assert_difference 'Video.count' do
      post :create, video: {youtube_id: "fake_id", title: "funny video"}
    end

    video = Video.last
    assert_equal "fake_id", video.youtube_id
    assert_equal "funny video", video.title
    assert_redirected_to search_videos_path
  end

  test "POST to :create doesn't create new video if youtube_id exists" do
    post :create, video: {youtube_id: "fake_id", title: "funny video"}

    assert_no_difference 'Video.count' do
      post :create, video: {youtube_id: "fake_id", title: "funny video"}
    end

    assert_redirected_to search_videos_path
  end

  test "POST to :create queues the video" do
    post :create, video: {youtube_id: "fake_id", title: "funny video"}

    video = Video.last
    assert video.queued?
  end

  test "GET to :play sets the current song to the next video" do
    next_video = videos(:funny_video)
    Video.expects(:pop).returns(next_video)

    get :play

    current = assigns(:current)
    assert_equal next_video, current
  end

  test "GET to :next sends next operation to event stream" do
    ESHQ.expects(:send).with(channel: 'video-queue', :data => {operation: 'next'}.to_json )

    get :next
    assert_redirected_to search_videos_path
  end
end
