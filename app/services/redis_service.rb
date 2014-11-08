class RedisService

  def self.add(youtube_links)
    client.set("youtube_links", youtube_links)
  end

  def self.next_link
    if links = fetch_links
      client.set("youtube_links", links[0..-2])
    end

    links.try(:last)
  end

  def self.list_links
    if links = fetch_links
      links.each { |link| puts link }
    end
  end

  private
  def self.client
    @client ||= Redis.new(:url => ENV["REDISCLOUD_URL"])
  end

  def self.fetch_links
    if unparsed_links = client.get("youtube_links")
      links = JSON.parse(unparsed_links)
    end
  end
end
