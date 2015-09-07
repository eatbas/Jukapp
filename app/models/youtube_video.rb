class YoutubeVideo < ActiveRecord::Base
  has_many :videos
  validates_presence_of :youtube_id
  validates_uniqueness_of :youtube_id

  before_create :initialize_from_youtube

  def self.search(query)
    videos_from_search = Yt::Collections::Videos.new.where(q: query, category: 'music', order: 'viewCount').first(50)
    videos_with_details = Yt::Collections::Videos.new.where(id: videos_from_search.map(&:id).join(','), part: 'contentDetails,status,snippet')

    videos_with_details.map do |video_response|
      new(youtube_id: video_response.id).tap { |v| v.apply_youtube_response(video_response) }
    end
  end

  def apply_youtube_response(response)
    self.title = response.title
    self.description = response.description
    self.length = response.duration
  end

  def initialize_from_youtube
    apply_youtube_response(Yt::Video.new(id: youtube_id))
  end

  def as_json(options={})
    merge_options = {}
    if current_room = options[:current_room]
      merge_options[:video] = Video.find_by(youtube_id: youtube_id, room_id: current_room)
    end

    super.merge(merge_options)
  end
end
