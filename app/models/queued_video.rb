class QueuedVideo < ActiveRecord::Base
  belongs_to :video
  belongs_to :room

  scope :queue_in, -> (room) { where(room_id: room.id) }
  scope :next_in,  -> (room) { queue_in(room).first }

  def self.queue(video, room)
    create(video_id: video.id, room_id: room.id)
    ESHQ.send( channel: "queue-#{room.id}", data: {operation: "new"}.to_json )
  end

  def play_and_destroy
    destroy.video.play
  end
end
