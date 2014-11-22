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

ActiveRecord::Schema.define(version: 20141122210006) do

  create_table "favorites", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "video_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["user_id", "video_id"], name: "index_favorites_on_user_id_and_video_id", unique: true
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id"
  add_index "favorites", ["video_id"], name: "index_favorites_on_video_id"

  create_table "queued_videos", force: true do |t|
    t.integer  "video_id"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "queued_videos", ["room_id", "video_id"], name: "index_queued_videos_on_room_id_and_video_id"
  add_index "queued_videos", ["room_id"], name: "index_queued_videos_on_room_id"
  add_index "queued_videos", ["video_id"], name: "index_queued_videos_on_video_id"

  create_table "recommended_videos", force: true do |t|
    t.integer  "video_id",   null: false
    t.integer  "room_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recommended_videos", ["room_id"], name: "index_recommended_videos_on_room_id"
  add_index "recommended_videos", ["video_id"], name: "index_recommended_videos_on_video_id"

  create_table "rooms", force: true do |t|
    t.string   "name",                   null: false
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id",   default: 1, null: false
  end

  add_index "rooms", ["name"], name: "index_rooms_on_name", unique: true
  add_index "rooms", ["owner_id"], name: "index_rooms_on_owner_id"

  create_table "users", force: true do |t|
    t.string   "username",               default: "", null: false
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

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
    t.string   "youtube_id", null: false
  end

  add_index "videos", ["youtube_id"], name: "index_videos_on_youtube_id"

end
