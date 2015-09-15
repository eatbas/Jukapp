class Video < ActiveRecord::Base
  belongs_to :room
  belongs_to :youtube_video, foreign_key: :youtube_id, primary_key: :youtube_id
  belongs_to :queued_by, class_name: "User", foreign_key: :queued_by
  belongs_to :prioritized_by, class_name: "User", foreign_key: :queued_by

  before_create :create_youtube_video

  self.per_page = 50

  default_scope { includes(:youtube_video) }

  validates_presence_of :youtube_id, :room_id
  validates_uniqueness_of :youtube_id, scope: :room_id

  scope :idle, -> { where(status: 'idle') }
  scope :queued, -> { where(status: 'queued').order(queued_at: :asc) }
  scope :prioritized, -> { where(status: 'prioritized').order(prioritized_at: :desc) }
  scope :on_player, -> { where(status: ['playing', 'paused']).order(played_at: :desc) }
  scope :not_on_player, -> { where.not(status: ['playing', 'paused']) }
  scope :playing, -> { where(status: 'playing') }
  scope :paused, -> { where(status: 'paused') }
  scope :current, -> { where(status: ['playing', 'paused']) }
  scope :now_playing, -> { playing.first }

  state_machine :status, :initial => :idle do
    after_transition on: :queue, :do => :on_queue
    before_transition queued: :playing, :do => :stop_currently_playing
    after_transition on: :play, :do => :on_play
    after_transition on: :prioritize, :do => :on_prioritize

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

  def self.possible_states
    self.state_machines[:status].states.map(&:name).map(&:to_s)
  end

  def stop_currently_playing
    self.class.stop_video_on_player(room)
  end

  def self.stop_video_on_player(room)
    # iterate just to make sure
    room.videos.on_player.each(&:stop)
  end

  def on_play
    set_current_time

    self.played_at = Time.now.utc
    self.play_count += 1
  end

  def on_queue(transition)
    self.queued_at = Time.now.utc

    self.queued_by =
    if params = transition.args.first
      params[:user]
    else
      nil
    end
  end

  def on_prioritize(transition)
    self.prioritized_at = Time.now.utc

    self.prioritized_by =
    if params = transition.args.first
      params[:user]
    else
      nil
    end
  end

  def set_current_time(time=0)
    RedisService.add(redis_key, time)
  end

  def current_time
    RedisService.get(redis_key).to_i
  end

  def redis_key
    "duration:#{room_id}"
  end

  def as_json(options={})
    options.merge!(methods: :current_time) if ['playing', 'paused'].include?(status)
    options.merge!(include: :youtube_video)

    super(options)
  end
end
