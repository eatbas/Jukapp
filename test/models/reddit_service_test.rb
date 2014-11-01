require 'test_helper'

class RedditServiceTest < ActiveSupport::TestCase
  test "#get_video_from gets videos from given subreddit" do
    RedditService.get_video_from("WTFMusicVideos")
  end

  # private
  # def stub_search
  #   Yourub::Client.any_instance.expects(:search)
  # end
end
