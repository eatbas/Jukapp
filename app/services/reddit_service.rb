class RedditService
  def self.get_video_from_subreddit(subreddit)
    redis_key = "subreddit:#{subreddit}"

    youtube_id = RedisService.pop_id(redis_key)

    unless youtube_id
      links = youtube_links_from_subreddit(subreddit).shuffle
      youtube_ids = links.map { |link| YoutubeService.get_youtube_id_from_url(link) }.compact

      RedisService.add(redis_key, youtube_ids[0..-2])
      youtube_id = youtube_ids.last
    end

    YoutubeService.get_video_by_id(youtube_id)
  end

  private
  def self.youtube_links_from_subreddit(subreddit)
    links_from_subreddit = client.links(subreddit, limit: 100)
    links_from_subreddit.map(&:url).select { |link| link =~ /youtu.?be/ }
  end

  def self.client
    @client ||= RedditKit::Client.new("Jukapp", ENV["REDDIT_PASSWORD"])
  end
end
