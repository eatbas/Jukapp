class YoutubeService
  def self.get_videos_for(query)
    query_with_music_category = { query: query, category: "music", max_results: 15 }

    client.search(query_with_music_category)

    client.videos.map { |video| structurize(video) }
  end

  def self.get_youtube_id_from_url(youtube_url)
    parse_url(youtube_url)
  end

  def self.get_video_by_id(youtube_id)
    structurize(client.search(id: youtube_id).first)
  end

  def self.get_video_from_list(youtube_list)
    playlist_response = client.client.execute!(
      :api_method => client.youtube.playlist_items.list,
      :parameters => {
        :playlistId => youtube_list,
        :part => "snippet"
      }
    )

    youtube_ids = Yourub::Reader.parse_videos(playlist_response).map {|v| v["id"]}
  end

  private
  def self.client
    @client ||= Yourub::Client.new
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

  def self.structurize(video)
    video[:youtube_id] = video.delete("id")
    OpenStruct.new(video)
  end
end
