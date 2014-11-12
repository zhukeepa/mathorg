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

ActiveRecord::Schema.define(version: 20141107015220) do

  create_table "explanation_parts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "explanations", force: true do |t|
    t.text     "description"
    t.string   "title"
    t.integer  "depth"
    t.string   "ordering"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body"
  end

  create_table "topic_child_parents", force: true do |t|
    t.float    "weight"
    t.integer  "parent_id"
    t.integer  "child_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topic_child_parents", ["child_id"], name: "index_topic_child_parents_on_child_id"
  add_index "topic_child_parents", ["parent_id"], name: "index_topic_child_parents_on_parent_id"

  create_table "topic_explanations", force: true do |t|
    t.integer "topic_id"
    t.integer "explanation_id"
  end

  add_index "topic_explanations", ["explanation_id"], name: "index_topic_explanations_on_explanation_id"
  add_index "topic_explanations", ["topic_id"], name: "index_topic_explanations_on_topic_id"

  create_table "topics", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
