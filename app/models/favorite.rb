class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :youtube_video, foreign_key: :youtube_id, primary_key: :youtube_id

  before_create :create_youtube_video

  validates_presence_of :user_id, :youtube_id
  validates_uniqueness_of :youtube_id, scope: :user_id

  def as_json(options={})
    merge_options = {}
    if current_room = options[:current_room]
      merge_options[:video] = Video.find_by(youtube_id: youtube_id, room_id: current_room)
    end

    super(include: :youtube_video).merge(merge_options)
  end
end
