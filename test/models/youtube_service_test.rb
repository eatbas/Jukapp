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

  test "#parse_url returns id from youtube url" do
    assert_equal "bltr_Dsk5EY", YoutubeService.parse_url("https://www.youtube.com/watch?v=bltr_Dsk5EY")
  end

  test "#parse_url returns id from minified youtube url" do
    assert_equal "ofmzX1nI7SE", YoutubeService.parse_url("http://youtu.be/ofmzX1nI7SE")
  end

  test "#parse_url raises if not youtube url" do
    assert_raise ArgumentError do
      YoutubeService.parse_url("www.google.com/v/1234")
    end
  end

  private
  def stub_search
    Yourub::Client.any_instance.expects(:search)
  end
end
