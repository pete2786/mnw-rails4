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

ActiveRecord::Schema.define(version: 20150407001003) do

  create_table "badges_sashes", force: :cascade do |t|
    t.integer  "badge_id"
    t.integer  "sash_id"
    t.boolean  "notified_user", default: false
    t.datetime "created_at"
  end

  add_index "badges_sashes", ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id"
  add_index "badges_sashes", ["badge_id"], name: "index_badges_sashes_on_badge_id"
  add_index "badges_sashes", ["sash_id"], name: "index_badges_sashes_on_sash_id"

  create_table "current_conditions", force: :cascade do |t|
    t.integer  "phrase_id"
    t.string   "location"
    t.integer  "temperature"
    t.string   "icon"
    t.string   "description"
    t.string   "code"
    t.decimal  "humidity",         precision: 15, scale: 10
    t.decimal  "lat",              precision: 15, scale: 10
    t.decimal  "long",             precision: 15, scale: 10
    t.decimal  "wind",             precision: 15, scale: 10
    t.text     "raw_response"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.integer  "user_id"
    t.text     "raw_forecast"
    t.boolean  "forecast_pending",                           default: true
  end

  add_index "current_conditions", ["phrase_id"], name: "index_current_conditions_on_phrase_id"

  create_table "locations", force: :cascade do |t|
    t.integer  "place_id"
    t.string   "name"
    t.decimal  "lat"
    t.decimal  "long"
    t.string   "country"
    t.string   "country2"
    t.string   "state"
    t.string   "time_zone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "population"
  end

  add_index "locations", ["place_id"], name: "index_locations_on_place_id"

  create_table "merit_actions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "action_method"
    t.integer  "action_value"
    t.boolean  "had_errors",    default: false
    t.string   "target_model"
    t.integer  "target_id"
    t.text     "target_data"
    t.boolean  "processed",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merit_activity_logs", force: :cascade do |t|
    t.integer  "action_id"
    t.string   "related_change_type"
    t.integer  "related_change_id"
    t.string   "description"
    t.datetime "created_at"
  end

  create_table "merit_score_points", force: :cascade do |t|
    t.integer  "score_id"
    t.integer  "num_points", default: 0
    t.string   "log"
    t.datetime "created_at"
  end

  create_table "merit_scores", force: :cascade do |t|
    t.integer "sash_id"
    t.string  "category", default: "default"
  end

  create_table "phrase_votes", force: :cascade do |t|
    t.integer  "phrase_id"
    t.integer  "user_id"
    t.integer  "value",      default: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "vote_type"
  end

  add_index "phrase_votes", ["phrase_id"], name: "index_phrase_votes_on_phrase_id"
  add_index "phrase_votes", ["user_id"], name: "index_phrase_votes_on_user_id"

  create_table "phrases", force: :cascade do |t|
    t.string   "season"
    t.string   "location"
    t.text     "phrase"
    t.text     "condition"
    t.text     "temperature"
    t.integer  "stock_image_id"
    t.string   "custom_image"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "user_id"
    t.boolean  "immortal",       default: false
    t.string   "time_period",    default: "any"
    t.string   "status",         default: "phrase"
  end

  create_table "sashes", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "saved_locations", force: :cascade do |t|
    t.string   "name"
    t.decimal  "lat",        precision: 15, scale: 10
    t.decimal  "long",       precision: 15, scale: 10
    t.integer  "user_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "saved_locations", ["user_id"], name: "index_saved_locations_on_user_id"

  create_table "stock_images", force: :cascade do |t|
    t.string   "image"
    t.string   "season"
    t.string   "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "image"
    t.string   "email"
    t.string   "token"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.boolean  "admin",      default: false
    t.integer  "sash_id"
    t.integer  "level",      default: 0
    t.string   "time_zone",  default: "Central Time (US & Canada)"
  end

end
