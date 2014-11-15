class RecommendedVideo < ActiveRecord::Base
  belongs_to :video
  belongs_to :room

  validates_presence_of :video, :room

  def self.add_videos_from_youtube_ids(youtube_ids, room_id)
    video_ids = youtube_ids.each do |youtube_id|

      video = Video.from_youtube(youtube_id, title: YoutubeService.get_title_from_youtube_id(youtube_id))
      RecommendedVideo.find_or_create_by(video_id: video.id, room_id: room_id)
      sleep 0.2
    end
  end
end
