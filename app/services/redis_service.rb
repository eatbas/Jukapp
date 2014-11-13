class RedisService

  def self.add(key, ids)
    client.set(key, ids)
  end

  def self.pop_id(key)
    if ids = fetch_ids(key)
      client.set(key, ids[0..-2])
    end

    ids.try(:last)
  end

  def self.list_ids(key)
    if ids = fetch_ids(key)
      ids.each { |id| puts id }
    end
  end

  def self.destroy_ids!(key)
    client.del(key)
  end

  private
  def self.client
    @client ||= Redis.new(:url => ENV["REDISCLOUD_URL"])
  end

  def self.fetch_ids(key)
    if unparsed_ids = client.get(key)
      ids = JSON.parse(unparsed_ids)
    end
  end
end
