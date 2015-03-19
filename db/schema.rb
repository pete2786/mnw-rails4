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

ActiveRecord::Schema.define(version: 20150319034737) do

  create_table "current_conditions", force: :cascade do |t|
    t.integer  "phrase_id"
    t.string   "location"
    t.integer  "temperature"
    t.string   "icon"
    t.string   "description"
    t.string   "code"
    t.decimal  "humidity"
    t.decimal  "lat"
    t.decimal  "long"
    t.decimal  "wind"
    t.text     "raw_response"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
  end

  add_index "current_conditions", ["phrase_id"], name: "index_current_conditions_on_phrase_id"

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
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "user_id"
    t.boolean  "immortal",       default: false
  end

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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
