class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates_presence_of :user_id
  validates_presence_of :video_id
end
