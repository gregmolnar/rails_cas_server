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

ActiveRecord::Schema.define(version: 20150205165624) do

  create_table "login_tickets", force: true do |t|
    t.string   "ticket",     null: false
    t.string   "host",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "login_tickets", ["ticket", "host"], name: "index_login_tickets_on_ticket_and_host"

  create_table "service_tickets", force: true do |t|
    t.string   "ticket",      null: false
    t.string   "host",        null: false
    t.string   "username",    null: false
    t.string   "service"
    t.string   "session_id",  null: false
    t.string   "cookie",      null: false
    t.datetime "consumed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "service_tickets", ["cookie"], name: "index_service_tickets_on_cookie"
  add_index "service_tickets", ["session_id"], name: "index_service_tickets_on_session_id"
  add_index "service_tickets", ["ticket"], name: "index_service_tickets_on_ticket"

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

end
