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

ActiveRecord::Schema.define(version: 20200229193421) do

  create_table "attendances", force: :cascade do |t|
    t.date "worked_on"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "started_at_before"
    t.datetime "started_at_before_2"
    t.datetime "started_at_before_3"
    t.datetime "started_at_before_4"
    t.datetime "started_at_before_5"
    t.datetime "finished_at_before"
    t.datetime "finished_at_before_2"
    t.datetime "finished_at_before_3"
    t.datetime "finished_at_before_4"
    t.datetime "finished_at_before_5"
    t.string "note"
    t.string "one_month_instructor_confirmation"
    t.string "one_month_instructor_confirmation_2"
    t.string "one_month_instructor_confirmation_3"
    t.string "one_month_instructor_confirmation_4"
    t.string "one_month_instructor_confirmation_5"
    t.string "notice_one_month_instructor_confirmation"
    t.string "notice_one_month_instructor_confirmation_2"
    t.string "notice_one_month_instructor_confirmation_3"
    t.string "notice_one_month_instructor_confirmation_4"
    t.string "notice_one_month_instructor_confirmation_5"
    t.string "change_digest"
    t.string "change_digest_2"
    t.string "change_digest_3"
    t.string "change_digest_4"
    t.string "change_digest_5"
    t.string "overwork_change"
    t.string "overwork_change_2"
    t.string "overwork_change_3"
    t.string "overwork_change_4"
    t.string "overwork_change_5"
    t.string "approval_change"
    t.string "approval_change_2"
    t.string "approval_change_3"
    t.string "approval_change_4"
    t.string "approval_change_5"
    t.string "approval_confirmation"
    t.string "approval_confirmation_2"
    t.string "approval_confirmation_3"
    t.string "approval_confirmation_4"
    t.string "approval_confirmation_5"
    t.string "approval_application"
    t.string "approval_application_2"
    t.string "approval_application_3"
    t.string "approval_application_4"
    t.string "approval_application_5"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "designated_work_start_time", default: "2022-01-04 01:00:00"
    t.datetime "designated_work_end_time", default: "2022-01-04 10:00:00"
    t.datetime "expected_end_time"
    t.string "next_day"
    t.string "business_processing_contents"
    t.string "instructor_confirmation"
    t.string "instructor_confirmation_2"
    t.string "instructor_confirmation_3"
    t.string "instructor_confirmation_4"
    t.string "instructor_confirmation_5"
    t.string "instructor_confirmation_app"
    t.string "instructor_confirmation_app_2"
    t.string "instructor_confirmation_app_3"
    t.string "instructor_confirmation_app_4"
    t.string "instructor_confirmation_app_5"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "bases", force: :cascade do |t|
    t.string "basename"
    t.string "basenumber"
    t.string "baseinfo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "designated_work_start_time", default: "2022-01-04 01:00:00"
    t.datetime "designated_work_end_time", default: "2022-01-04 10:00:00"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "department"
    t.string "affiliation"
    t.datetime "basic_time", default: "2022-01-03 23:00:00"
    t.datetime "work_time", default: "2022-01-03 22:30:00"
    t.boolean "superior", default: false
    t.boolean "superiorA", default: false
    t.boolean "superiorB", default: false
    t.boolean "superiorC", default: false
    t.boolean "generalA", default: false
    t.boolean "generalB", default: false
    t.integer "uid"
    t.integer "employee_number"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
