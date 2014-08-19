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

ActiveRecord::Schema.define(version: 20140819132553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "goals", force: true do |t|
    t.integer  "match_id"
    t.integer  "player_id"
    t.integer  "minute"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "goals", ["match_id"], name: "index_goals_on_match_id", using: :btree
  add_index "goals", ["player_id"], name: "index_goals_on_player_id", using: :btree

  create_table "matches", force: true do |t|
    t.integer  "home_id"
    t.integer  "guest_id"
    t.date     "match_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matches", ["guest_id"], name: "index_matches_on_guest_id", using: :btree
  add_index "matches", ["home_id"], name: "index_matches_on_home_id", using: :btree

  create_table "players", force: true do |t|
    t.integer  "team_id"
    t.string   "player_name"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["team_id"], name: "index_players_on_team_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "team_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
