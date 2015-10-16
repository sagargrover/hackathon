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

ActiveRecord::Schema.define(version: 20151016192555) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "seeds", force: true do |t|
    t.string   "title"
    t.boolean  "is_public"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creator_id"
    t.spatial  "coordinates", limit: {:srid=>4326, :type=>"point"}
    t.integer  "yays",                                              default: 0
    t.integer  "nays",                                              default: 0
  end

  create_table "seens", id: false, force: true do |t|
    t.integer  "id",         default: "nextval('seens_id_seq'::regclass)", null: false
    t.integer  "seed_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.integer "seed_id"
    t.string  "tagged_user_id"
    t.string  "tagger_user_id"
  end

  create_table "users", force: true do |t|
    t.string "handle"
    t.text   "auth_token"
    t.string "name"
    t.string "user_id"
  end

end
