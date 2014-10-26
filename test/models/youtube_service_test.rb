require 'test_helper'

class YoutubeServiceTest < ActiveSupport::TestCase
  test "#get_videos_for searches youtube with the query" do
    stub_search.with({ query: "funny", category: "music", max_results: 15 })
    YoutubeService.get_videos_for("funny")
  end

  test "#get_videos_for retrieves videos from youtube" do
    stub_search
    Yourub::Client.any_instance.expects(:videos).returns([{"id" => "abc123", "title" => "some_title"}])
    YoutubeService.get_videos_for("funny")
  end

  test "#get_videos_for returns videos in OpenStruct" do
    stub_search
    Yourub::Client.any_instance.expects(:videos).returns([{"id" => "abc123", "title" => "some_title"}])
    video = YoutubeService.get_videos_for("funny").first

    assert_equal "abc123", video.youtube_id
    assert_equal "some_title", video.title
  end

  private
  def stub_search
    Yourub::Client.any_instance.expects(:search)
  end
end
