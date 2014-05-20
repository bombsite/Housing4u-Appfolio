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

ActiveRecord::Schema.define(version: 201405190000012) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "adminpack"

  create_table "cities", force: true do |t|
    t.string  "name"
    t.integer "state_id"
  end

  create_table "states", force: true do |t|
    t.string "name"
  end

  create_table "unit_photos", force: true do |t|
    t.integer "unit_id",       null: false
    t.text    "image_url",     null: false
    t.text    "image_caption"
  end

  create_table "units", force: true do |t|
    t.integer  "user_id"
    t.string   "appfolio_reference_id"
    t.string   "appfolio_category"
    t.boolean  "allow_email_contact",   default: true,  null: false
    t.boolean  "show_address",          default: true,  null: false
    t.boolean  "show_map",              default: true,  null: false
    t.boolean  "multi_unit",            default: false, null: false
    t.text     "ad_headline"
    t.text     "ad_content"
    t.text     "property_address"
    t.string   "property_postal_code"
    t.text     "tour_video"
    t.integer  "city_id"
    t.integer  "state_id"
    t.float    "rent_max"
    t.float    "square_foot_min"
    t.float    "bedrooms"
    t.float    "bathrooms"
    t.float    "deposit_max"
    t.datetime "availability_date"
    t.float    "lease_application_fee"
    t.text     "amenities"
    t.boolean  "active",                default: true,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.text     "formatted_address"
  end

  create_table "users", force: true do |t|
    t.string   "email",                    default: "",    null: false
    t.string   "encrypted_password",       default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",          default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number"
    t.string   "company_name"
    t.string   "provider"
    t.string   "uid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.boolean  "smoker",                   default: false
    t.string   "language_spoken"
    t.boolean  "pets",                     default: false
    t.boolean  "bed_before_11pm",          default: false
    t.boolean  "wake_before_9am",          default: false
    t.boolean  "music_often",              default: false
    t.boolean  "visitors_often",           default: false
    t.boolean  "social",                   default: false
    t.string   "smoker_accepted",          default: "No"
    t.string   "pets_accepted",            default: "No"
    t.string   "bed_before_11pm_accepted", default: "No"
    t.string   "wake_before_9am_accepted", default: "No"
    t.string   "music_often_accepted",     default: "No"
    t.string   "visitors_often_accepted",  default: "No"
    t.string   "social_accepted",          default: "No"
    t.boolean  "survey_completed",         default: false
    t.string   "fb_photo_url"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  add_foreign_key "cities", "states", name: "cities_state_id_fk"

  add_foreign_key "unit_photos", "units", name: "unit_photos_unit_id_fk"

  add_foreign_key "units", "cities", name: "units_city_id_fk"
  add_foreign_key "units", "states", name: "units_state_id_fk"
  add_foreign_key "units", "users", name: "units_user_id_fk"

end
