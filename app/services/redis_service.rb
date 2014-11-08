class RedisService

  def self.add(youtube_links)
    client.set("youtube_links", youtube_links)
  end

  def self.pop_link(random:true)
    if links = fetch_links
      client.set("youtube_links", links[0..-2])
    end

    random ? links.try(:sample) : links.try(:last)
  end

  def self.list_links
    if links = fetch_links
      links.each { |link| puts link }
    end
  end

  def self.destroy_links!
    client.del("youtube_links")
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
