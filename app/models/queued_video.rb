class QueuedVideo < ActiveRecord::Base
  belongs_to :video
  belongs_to :room
end
