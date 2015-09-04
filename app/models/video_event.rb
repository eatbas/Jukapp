class VideoEvent < ActiveRecord::Base
  belongs_to :room
  belongs_to :video

  scope :top_ten_in, -> (room) { where(room_id: room.id).order('play_count DESC').first(10) }
  scope :last_ten_in, -> (room) { where(room_id: room.id).order('played_at DESC').first(10) }

  self.per_page = 50

  # def self.play(video, room)
  #   event = VideoEvent.find_or_create_by(video: video, room: room)
  #   event.update!(play_count: event.play_count+1, played_at: Time.now)
  # end

  attr_accessor :queued_at, :queued_by, :played_at, :play_count, :prioritized_at, :prioritized_by

  state_machine :state, initial: :idle do
    before_transition parked: :any - :parked, do: :put_on_seatbelt

    after_transition on: :queue, :do => [:set_queued_at, :set_queued_by]
    # after_transition on: :play, :do => [:increment_play_count, :set_played_at]
    # after_transition on: :prioritize, :do => [:prioritized_at, :prioritized_by]

    event :queue do
      transition :idle => :queued
    end

    event :delete do
      transition :queued => :idle
    end

    ## PLAY
    # event :play do
    #   transition [:queued, :prioritized] => :playing
    # end

    # event :stop do
    #   transition [:playing, :paused] => :idle
    # end

    ## PRIORITIZE
    # event :prioritize do
    #   transition :queued => :prioritize
    # end

    # event :unprioritize do
    #   transition :prioritize => :queued
    # end
  end
end
