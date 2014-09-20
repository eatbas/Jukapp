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
end
