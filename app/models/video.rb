class Video < ActiveRecord::Base
  belongs_to :room
  belongs_to :youtube_video
  belongs_to :queued_by, class_name: "User", foreign_key: :queued_by
  belongs_to :prioritized_by, class_name: "User", foreign_key: :queued_by

  validates_presence_of :youtube_video_id, :room_id

  scope :queued, -> { where(status: 'queued').order(queued_at: :asc) }
  scope :prioritized, -> { where(status: 'prioritized').order(prioritized_at: :desc) }
  scope :currently_playing, -> { where(status: 'playing').order(played_at: :desc).first }
  scope :now_playing, -> { where(status: 'playing').order(played_at: :desc).first }

  state_machine :status, :initial => :idle do
    after_transition on: :queue, :do => [:set_queued_at, :set_queued_by]
    after_transition on: :play, :do => [:increment_play_count, :set_played_at]
    # after_transition on: :prioritize, :do => [:prioritized_at, :prioritized_by]

    event :queue do
      transition :idle => :queued
    end

    event :dequeue do
      transition [:queued, :prioritized] => :idle
    end

    event :play do
      transition [:queued, :prioritized] => :playing
    end

    event :pause do
      transition :playing => :paused
    end

    event :continue do
      transition :paused => :playing
    end

    event :stop do
      transition [:playing, :paused] => :idle
    end

    event :prioritize do
      transition :queued => :prioritized
    end

    event :deprioritize do
      transition :prioritized => :queued
    end
  end

  def initialize_from_youtube(youtube_id)
    self.youtube_video = YoutubeVideo.find_or_create_by(youtube_id: youtube_id)
  end

  def set_queued_at
    self.queued_at = Time.now.utc
  end

  def set_queued_by(transition)
    self.queued_by = if params = transition.args.first
      params[:user]
    end
  end

  def increment_play_count
    self.play_count += 1
  end

  def set_played_at
    self.played_at = Time.now.utc
  end

  def as_json(options={})
    super(include: :youtube_video)
  end

  # def play_in(room)
  #   VideoEvent.play(self, room)
  #   self
  # end
end
