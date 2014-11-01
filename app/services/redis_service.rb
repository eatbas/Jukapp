class RedisService

  def self.add(youtube_links)
    client.set("youtube_links", youtube_links)
  end

  def self.next_link
    if unparsed_links = client.get("youtube_links")
      links = JSON.parse(unparsed_links)
      client.set("youtube_links", links[0..-2])
    end

    links.try(:last)
  end

  private
  def self.client
    @client ||= Redis.new(:url => ENV["REDISCLOUD_URL"])
  end
end
