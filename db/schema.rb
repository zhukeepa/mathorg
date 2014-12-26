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

ActiveRecord::Schema.define(version: 20141226225303) do

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

  create_table "explanation_parts", force: true do |t|
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
    t.text     "body"
    t.integer  "user_id"
  end

  add_index "explanations", ["user_id"], name: "index_explanations_on_user_id", using: :btree

  create_table "problem_resources", force: true do |t|
    t.text     "problem_ids"
    t.text     "title"
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "problems", force: true do |t|
    t.text     "body"
    t.text     "source"
    t.text     "author"
    t.boolean  "show_solution"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
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

  create_table "topic_categorizables", force: true do |t|
    t.float    "weight"
    t.integer  "categorizable_id"
    t.string   "categorizable_type"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topic_categorizables", ["categorizable_id"], name: "topic_categorizables_index", using: :btree
  add_index "topic_categorizables", ["topic_id"], name: "index_topic_categorizables_on_topic_id", using: :btree

  create_table "topic_child_parents", force: true do |t|
    t.float    "weight"
    t.integer  "parent_id"
    t.integer  "child_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topic_child_parents", ["child_id"], name: "index_topic_child_parents_on_child_id", using: :btree
  add_index "topic_child_parents", ["parent_id"], name: "index_topic_child_parents_on_parent_id", using: :btree

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
