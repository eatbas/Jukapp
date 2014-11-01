class RedditService
  def self.get_video_from(subreddit)
    client = RedditKit::Client.new("Jukapp", ENV["REDDIT_PASSWORD"])
    client.links(subreddit)
    byebug
  end
end
