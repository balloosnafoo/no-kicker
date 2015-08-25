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

ActiveRecord::Schema.define(version: 20150821220834) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "author_id",  null: false
    t.integer  "message_id", null: false
    t.integer  "parent_id"
    t.text     "body",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "name"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "images", ["imageable_id"], name: "index_images_on_imageable_id", using: :btree

  create_table "league_invites", force: :cascade do |t|
    t.integer  "league_id",  null: false
    t.string   "username"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leagues", force: :cascade do |t|
    t.integer  "commissioner_id"
    t.integer  "num_teams",                       null: false
    t.integer  "num_divisions",                   null: false
    t.boolean  "public",          default: true,  null: false
    t.boolean  "redraft",         default: true,  null: false
    t.string   "match_type",      default: "h2h", null: false
    t.string   "name",                            null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "matchups", force: :cascade do |t|
    t.integer  "team_1_id",                null: false
    t.integer  "team_2_id",                null: false
    t.integer  "team_1_score", default: 0
    t.integer  "team_2_score", default: 0
    t.integer  "league_id",                null: false
    t.integer  "week",                     null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "author_id",  null: false
    t.integer  "league_id",  null: false
    t.string   "title",      null: false
    t.text     "body",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nflgames", force: :cascade do |t|
    t.string   "home_team",  null: false
    t.string   "away_team",  null: false
    t.integer  "home_score", null: false
    t.integer  "away_score", null: false
    t.integer  "week",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "player_contracts", force: :cascade do |t|
    t.integer  "team_id",    null: false
    t.integer  "player_id",  null: false
    t.integer  "league_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "player_contracts", ["team_id", "player_id"], name: "index_player_contracts_on_team_id_and_player_id", unique: true, using: :btree

  create_table "players", force: :cascade do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "position",   null: false
    t.string   "team_name",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roster_rules", force: :cascade do |t|
    t.integer  "league_id",              null: false
    t.integer  "num_qb",     default: 1, null: false
    t.integer  "num_rb",     default: 2, null: false
    t.integer  "num_wr",     default: 2, null: false
    t.integer  "num_te",     default: 1, null: false
    t.integer  "num_flex",   default: 1, null: false
    t.integer  "num_dst",    default: 0, null: false
    t.integer  "num_k",      default: 0, null: false
    t.integer  "num_bench",  default: 6, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "roster_slots", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "team_id",    null: false
    t.string   "position",   null: false
    t.integer  "order",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "score_rules", force: :cascade do |t|
    t.integer  "league_id",                    null: false
    t.integer  "rushing_yds",   default: 10,   null: false
    t.integer  "rushing_tds",   default: 800,  null: false
    t.integer  "receiving_yds", default: 10,   null: false
    t.integer  "receiving_tds", default: 800,  null: false
    t.integer  "receiving_rec", default: 0,    null: false
    t.integer  "passing_yds",   default: 5,    null: false
    t.integer  "passing_tds",   default: 600,  null: false
    t.integer  "passing_int",   default: -200, null: false
    t.integer  "fumbles_lost",  default: -200, null: false
    t.integer  "sack",          default: 100,  null: false
    t.integer  "def_int",       default: 200,  null: false
    t.integer  "fumble_rec",    default: 200,  null: false
    t.integer  "def_td",        default: 600,  null: false
    t.integer  "safety",        default: 200,  null: false
    t.integer  "block_kick",    default: 200,  null: false
    t.integer  "ret_td",        default: 600,  null: false
    t.integer  "fourth_stops",  default: 200,  null: false
    t.integer  "pts_allow1",    default: 1000, null: false
    t.integer  "pts_allow2",    default: 700,  null: false
    t.integer  "pts_allow3",    default: 400,  null: false
    t.integer  "pts_allow4",    default: 100,  null: false
    t.integer  "pts_allow5",    default: 0,    null: false
    t.integer  "pts_allow6",    default: 0,    null: false
    t.integer  "pts_allow7",    default: -300, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "league_id",  null: false
    t.integer  "division",   null: false
    t.integer  "manager_id"
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trade_items", force: :cascade do |t|
    t.integer  "player_id",      null: false
    t.integer  "owner_id",       null: false
    t.integer  "trade_offer_id", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "trade_offers", force: :cascade do |t|
    t.integer  "league_id",                 null: false
    t.integer  "trader_id",                 null: false
    t.integer  "tradee_id",                 null: false
    t.boolean  "pending",    default: true, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",        null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "weekly_stats", force: :cascade do |t|
    t.integer  "player_id",                 null: false
    t.integer  "week",                      null: false
    t.integer  "rushing_att",   default: 0
    t.integer  "rushing_tds",   default: 0
    t.integer  "rushing_yds",   default: 0
    t.integer  "fumbles_lost",  default: 0
    t.integer  "passing_att",   default: 0
    t.integer  "passing_int",   default: 0
    t.integer  "passing_tds",   default: 0
    t.integer  "passing_yds",   default: 0
    t.integer  "receiving_rec", default: 0
    t.integer  "receiving_tar", default: 0
    t.integer  "receiving_tds", default: 0
    t.integer  "receiving_yds", default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "weeks", force: :cascade do |t|
    t.integer  "current_week", default: 0, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

end
