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

ActiveRecord::Schema.define(version: 20150205145035) do

  create_table "contractor_services", force: :cascade do |t|
    t.integer  "contractor_id",      limit: 4
    t.integer  "service_id",         limit: 4
    t.date     "service_start_date"
    t.date     "service_end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contractor_statuses", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contractors", force: :cascade do |t|
    t.string   "commercial_name", limit: 255
    t.string   "business_name",   limit: 255
    t.string   "rut",             limit: 255
    t.string   "email",           limit: 255
    t.string   "temporality",     limit: 255
    t.integer  "status_id",       limit: 4
    t.integer  "services_amt",    limit: 4
    t.integer  "workers_amt",     limit: 4
    t.string   "observations",    limit: 255
    t.string   "address",         limit: 255
    t.integer  "region",          limit: 4
    t.integer  "comuna",          limit: 4
    t.integer  "country",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_profiles", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "training_course_members", force: :cascade do |t|
    t.integer  "training_course_id", limit: 4
    t.integer  "worker_id",          limit: 4
    t.decimal  "attendance",                   precision: 3, scale: 1
    t.decimal  "grade",                        precision: 3, scale: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "training_courses", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "course_subject", limit: 255
    t.integer  "speaker_id",     limit: 4
    t.integer  "training_id",    limit: 4
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "finished",       limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trainings", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "description",     limit: 255
    t.integer  "validity_period", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.string   "lang",         limit: 255,   default: "0"
    t.date     "first_access"
    t.date     "last_access"
    t.text     "description",  limit: 65535
    t.boolean  "confirmed",    limit: 1
    t.boolean  "deleted",      limit: 1
    t.boolean  "suspended",    limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workers", force: :cascade do |t|
    t.string   "firstname",     limit: 255
    t.string   "lastname1",     limit: 255
    t.string   "lastname2",     limit: 255
    t.string   "fullname",      limit: 255
    t.string   "rut",           limit: 255
    t.integer  "contractor_id", limit: 4
    t.date     "birthday"
    t.string   "gender",        limit: 255
    t.string   "address",       limit: 255
    t.integer  "region",        limit: 4
    t.integer  "comuna",        limit: 4
    t.integer  "country",       limit: 4
    t.string   "phone",         limit: 255
    t.string   "cellphone",     limit: 255
    t.string   "email",         limit: 255
    t.string   "observations",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
