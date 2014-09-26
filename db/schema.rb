# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140926203831) do

  create_table "queued_videos", force: true do |t|
    t.integer  "video_id"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "queued_videos", ["room_id"], name: "index_queued_videos_on_room_id"

  create_table "rooms", force: true do |t|
    t.string   "name"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "video_events", force: true do |t|
    t.integer  "room_id"
    t.integer  "video_id"
    t.integer  "play_count", default: 0
    t.datetime "played_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "video_events", ["room_id"], name: "index_video_events_on_room_id"
  add_index "video_events", ["video_id"], name: "index_video_events_on_video_id"

  create_table "videos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "youtube_id"
    t.datetime "played_at"
    t.datetime "queued_at"
    t.integer  "play_count", default: 0
    t.string   "status"
  end

  add_index "videos", ["youtube_id"], name: "index_videos_on_youtube_id"

end
