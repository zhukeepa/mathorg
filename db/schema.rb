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

ActiveRecord::Schema.define(version: 20150715053711) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "explanation_authors", force: true do |t|
    t.float    "weight"
    t.integer  "user_id"
    t.integer  "explanation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "explanations", force: true do |t|
    t.text     "description"
    t.text     "title"
    t.integer  "depth"
    t.text     "ordering"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.text     "authors"
  end

  add_index "explanations", ["user_id"], name: "index_explanations_on_user_id", using: :btree

  create_table "marks", id: false, force: true do |t|
    t.integer  "marker_id"
    t.string   "marker_type"
    t.integer  "markable_id"
    t.string   "markable_type"
    t.string   "mark",          limit: 128
    t.datetime "created_at"
  end

  add_index "marks", ["markable_id", "markable_type", "mark"], name: "index_marks_on_markable_id_and_markable_type_and_mark", using: :btree
  add_index "marks", ["marker_id", "marker_type", "mark"], name: "index_marks_on_marker_id_and_marker_type_and_mark", using: :btree

  create_table "problem_sets", force: true do |t|
    t.text     "problem_order"
    t.string   "name"
    t.boolean  "official"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "problem_sets_problems", id: false, force: true do |t|
    t.integer "problem_id"
    t.integer "problem_set_id"
  end

  add_index "problem_sets_problems", ["problem_id"], name: "index_problem_sets_problems_on_problem_id", using: :btree
  add_index "problem_sets_problems", ["problem_set_id"], name: "index_problem_sets_problems_on_problem_set_id", using: :btree

  create_table "problems", force: true do |t|
    t.text     "body"
    t.text     "source"
    t.text     "author"
    t.boolean  "show_solution"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.integer  "original_id"
  end

  add_index "problems", ["original_id"], name: "index_problems_on_original_id", using: :btree

  create_table "rich_texts", force: true do |t|
    t.text     "text"
    t.integer  "bodyable_id"
    t.string   "bodyable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "format"
  end

  create_table "solutions", force: true do |t|
    t.text     "hints"
    t.integer  "problem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body"
    t.integer  "author_id"
  end

  add_index "solutions", ["author_id"], name: "index_solutions_on_author_id", using: :btree
  add_index "solutions", ["problem_id"], name: "index_solutions_on_problem_id", using: :btree

  create_table "topic_topicables", force: true do |t|
    t.float    "weight"
    t.integer  "topicable_id"
    t.string   "topicable_type"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topic_topicables", ["topic_id"], name: "index_topic_topicables_on_topic_id", using: :btree
  add_index "topic_topicables", ["topicable_id"], name: "topic_topicables_index", using: :btree

  create_table "topics", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.text     "email",                  default: "", null: false
    t.text     "encrypted_password",     default: "", null: false
    t.text     "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.text     "current_sign_in_ip"
    t.text     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.text     "votable_type"
    t.integer  "voter_id"
    t.text     "voter_type"
    t.boolean  "vote_flag"
    t.text     "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
