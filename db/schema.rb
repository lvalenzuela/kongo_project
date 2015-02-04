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

ActiveRecord::Schema.define(version: 20150203190257) do

  create_table "users", force: :cascade do |t|
    t.string   "username",     limit: 255
    t.string   "password",     limit: 255
    t.string   "idnumber",     limit: 255
    t.string   "firstname",    limit: 255
    t.string   "lastname",     limit: 255
    t.string   "name",         limit: 255
    t.string   "email",        limit: 255
    t.string   "phone1",       limit: 255
    t.string   "phone2",       limit: 255
    t.string   "auth_token",   limit: 255
    t.string   "company_name", limit: 255
    t.string   "department",   limit: 255
    t.string   "address",      limit: 255
    t.string   "city",         limit: 255
    t.integer  "lang_id",      limit: 4
    t.date     "first_access"
    t.date     "last_access"
    t.text     "description",  limit: 65535
    t.boolean  "confirmed",    limit: 1
    t.boolean  "deleted",      limit: 1
    t.boolean  "suspended",    limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
