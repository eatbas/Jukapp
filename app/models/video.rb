class Video < ActiveRecord::Base

  scope :queued, -> { where(status: "queued").order("queued_at ASC") }

  def queued?
    status == "queued"
  end

  def queue
    update(status: "queued", queued_at: Time.now)
  end

  def play
    raise "Not queued yet" unless queued?
    update(status: "played", played_at: Time.now, play_count: play_count+1)
  end

  def self.pop
    next_video = queued.to_a.reverse.pop
    next_video.play
    next_video
  end
end
