class YoutubeService
  def self.get_videos_for(query)
    client = Yourub::Client.new

    query_with_music_category = { query: query, category: "music", max_results: 15 }

    client.search(query_with_music_category)
    client.videos
  end
end
