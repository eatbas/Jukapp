class Video < ActiveRecord::Base

  scope :queued, -> { where(status: "queued").order("queued_at ASC") }

  def queued?
    status == "queued"
  end

  def queue
    update(status: "queued", queued_at: Time.now)
    ESHQ.send( channel: "video-queue", data: {operation: "new"}.to_json )
  end

  def play
    raise "Not queued yet" unless queued?
    update(status: "played", played_at: Time.now, play_count: play_count+1)
  end

  def self.pop
    next_video = queued.to_a.reverse.pop
    next_video.try(:play)
    next_video
  end
end
