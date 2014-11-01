class RedditService
  def self.get_video_from(subreddit)
    client = RedditKit::Client.new("Jukapp", ENV["REDDIT_PASSWORD"])
    youtube_url = client.links(subreddit, limit: 1).first.url
    YoutubeService.get_video_from_url(youtube_url)
  end
end
