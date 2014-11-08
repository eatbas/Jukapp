class RedisService

  def self.add(key, youtube_links)
    client.set(key, youtube_links)
  end

  def self.pop_link(key, random:true)
    if links = fetch_links(key)
      client.set(key, links[0..-2])
    end

    random ? links.try(:sample) : links.try(:last)
  end

  def self.list_links(key)
    if links = fetch_links(key)
      links.each { |link| puts link }
    end
  end

  def self.destroy_links!(key)
    client.del(key)
  end

  private
  def self.client
    @client ||= Redis.new(:url => ENV["REDISCLOUD_URL"])
  end

  def self.fetch_links(key)
    if unparsed_links = client.get(key)
      links = JSON.parse(unparsed_links)
    end
  end
end
