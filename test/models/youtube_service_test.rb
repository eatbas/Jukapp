require 'test_helper'

class YoutubeServiceTest < ActiveSupport::TestCase
  test "#get_videos_for searches youtube with the query" do
    Yourub::Client.any_instance.expects(:search).with({ query: "funny", category: "music", max_results: 15 })
    YoutubeService.get_videos_for("funny")
  end

  test "#get_videos_for retrieves videos from youtube" do
    Yourub::Client.any_instance.expects(:videos)
    YoutubeService.get_videos_for("funny")
  end
end
