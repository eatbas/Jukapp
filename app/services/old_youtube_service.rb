class OldYoutubeService
  def self.get_videos_for(query)
    query_with_music_category = { query: query, category: "music", max_results: 15 }

    retrieve_videos(query_with_music_category)
  end

  def self.get_youtube_id_from_url(youtube_url)
    parse_url(youtube_url)
  end

  def self.get_video_by_id(youtube_id)
    client = Yourub::Client.new
    client.search(id: youtube_id)
    structurize(client.videos.first)
  end

  def self.get_video_from_list(youtube_list)
    redis_key = "youtube_list:#{youtube_list}"

    youtube_id = RedisService.pop_id(redis_key)

    unless youtube_id
      youtube_ids = fetch_youtube_ids(youtube_list)

      RedisService.add(redis_key, youtube_ids[0..-2])
      youtube_id = youtube_ids.last
    end

    get_video_by_id(youtube_id)
  end

  def self.fetch_youtube_ids(youtube_list)
    options = {
      playlistId: youtube_list,
      part: "contentDetails",
      maxResults: 50
    }

    # options.merge!(pageToken: "CGQQAA")

    client = Yourub::Client.new
    playlist_response = client.client.execute!(
      api_method: client.youtube.playlist_items.list,
      parameters: options
    )

    Yourub::Reader.parse_videos(playlist_response).map {|v| v["contentDetails"]["videoId"]}
  end

  private
  def self.retrieve_videos(query)
    client = Yourub::Client.new
    client.search(query)
    client.videos.map { |video| Video.find_by(youtube_id: video["id"]) || Video.new(youtube_id: video["id"], title: video["title"]) }
  end

  def self.parse_url(youtube_url)
    raise ArgumentError, "not a youtube url" unless youtube_url =~ /youtu.?be/
    youtube_uri = URI(youtube_url)
    if query = youtube_uri.query
      youtube_cgi = CGI::parse(query)
      youtube_cgi["v"].try(:first) || youtube_cgi["V"].try(:first)
    else
      youtube_url.last(11)
    end
  end
end
