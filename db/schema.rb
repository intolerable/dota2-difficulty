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

ActiveRecord::Schema.define(version: 20130717192624) do

  create_table "elo_instances", force: true do |t|
    t.integer  "rating"
    t.integer  "games"
    t.boolean  "pro"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "heroes", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "upper_id"
    t.integer  "lower_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results", force: true do |t|
    t.integer  "winner_id"
    t.integer  "loser_id"
    t.string   "mode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "results", ["loser_id"], name: "index_results_on_loser_id"
  add_index "results", ["winner_id"], name: "index_results_on_winner_id"

end
