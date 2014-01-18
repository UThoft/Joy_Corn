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

ActiveRecord::Schema.define(version: 20140115005740) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audios", force: true do |t|
    t.integer "post_id", null: false
    t.string  "link",    null: false
  end

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "holder_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "commentable_url"
    t.string   "commentable_title"
    t.string   "commentable_state"
    t.string   "anchor"
    t.string   "title"
    t.string   "contacts"
    t.text     "raw_content"
    t.text     "content"
    t.string   "view_token"
    t.string   "state",             default: "draft"
    t.string   "ip",                default: "undefined"
    t.string   "referer",           default: "undefined"
    t.string   "user_agent",        default: "undefined"
    t.integer  "tolerance_time"
    t.boolean  "spam",              default: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth",             default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.integer "post_id", null: false
    t.string  "link",    null: false
  end

  create_table "ip_cities", id: false, force: true do |t|
    t.integer "ip_start",       limit: 8,   null: false
    t.integer "ip_end",         limit: 8
    t.string  "country_code_s", limit: 2
    t.string  "country_code_l", limit: 3
    t.string  "location",       limit: 100
  end

  create_table "likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string    "media_type",                                                    null: false
    t.integer   "user_id",                                                       null: false
    t.timestamp "created_at",                          precision: 6
    t.timestamp "updated_at",                          precision: 6
    t.string    "title",                    limit: 64
    t.integer   "draft_comments_count",                              default: 0
    t.integer   "published_comments_count",                          default: 0
    t.integer   "deleted_comments_count",                            default: 0
  end

  create_table "posts_tags", id: false, force: true do |t|
    t.integer "post_id", null: false
    t.integer "tag_id",  null: false
  end

  create_table "tags", force: true do |t|
    t.string "name", null: false
  end

  create_table "texts", force: true do |t|
    t.integer "post_id"
    t.string  "content", limit: 1024, null: false
  end

  create_table "unlike", force: true do |t|
    t.integer  "user_id"
    t.integer  "posts_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.timestamp "created_at",                  precision: 6
    t.timestamp "updated_at",                  precision: 6
    t.string    "email",                                     default: "", null: false
    t.string    "encrypted_password",                        default: "", null: false
    t.string    "reset_password_token"
    t.datetime  "reset_password_sent_at"
    t.datetime  "remember_created_at"
    t.integer   "sign_in_count",                             default: 0,  null: false
    t.datetime  "current_sign_in_at"
    t.datetime  "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.string    "confirmation_token"
    t.datetime  "confirmed_at"
    t.datetime  "confirmation_sent_at"
    t.string    "unconfirmed_email"
    t.integer   "my_draft_comments_count",                   default: 0
    t.integer   "my_published_comments_count",               default: 0
    t.integer   "my_comments_count",                         default: 0
    t.integer   "draft_comcoms_count",                       default: 0
    t.integer   "published_comcoms_count",                   default: 0
    t.integer   "deleted_comcoms_count",                     default: 0
    t.integer   "spam_comcoms_count",                        default: 0
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "videos", force: true do |t|
    t.integer "post_id", null: false
    t.string  "link",    null: false
  end

end
