class RedditService
  def self.get_video_from(subreddit)
    youtube_url = RedisService.next_link

    unless youtube_url
      links = youtube_links_from(subreddit)
      RedisService.add(links[0..-2])
      youtube_url = links.last
    end

    YoutubeService.get_video_from_url(youtube_url)
  end

  private
  def self.youtube_links_from(subreddit)
    client.links(subreddit).map(&:url).select { |link| link =~ /youtu.?be/ }
  end

  def self.client
    @client ||= RedditKit::Client.new("Jukapp", ENV["REDDIT_PASSWORD"])
  end
end
