class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates_presence_of :user_id
  validates_presence_of :video_id

  def as_json(options={})
    super(include: {video: {include: :video_events}})
  end
end
