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

ActiveRecord::Schema.define(version: 20180215174906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bus_stations", force: :cascade do |t|
    t.boolean  "is_source"
    t.boolean  "is_destination"
    t.integer  "sequence"
    t.string   "arrival_time"
    t.string   "departure_time"
    t.integer  "price"
    t.datetime "duration"
    t.integer  "vehicle_id"
    t.integer  "station_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["station_id"], name: "index_bus_stations_on_station_id", using: :btree
    t.index ["vehicle_id"], name: "index_bus_stations_on_vehicle_id", using: :btree
  end

  create_table "driver_user_fairs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "driver_id"
    t.integer  "fair_status"
    t.integer  "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["driver_id"], name: "index_driver_user_fairs_on_driver_id", using: :btree
    t.index ["user_id"], name: "index_driver_user_fairs_on_user_id", using: :btree
  end

  create_table "drivers", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name"
    t.string   "aadhar_number"
    t.string   "dl_number"
    t.string   "dl_image"
    t.string   "permanenet_address"
    t.string   "temprorary_address"
    t.string   "driver_unique_number"
    t.string   "token"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "fcm_token"
    t.string   "phone_number"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_drivers_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_drivers_on_reset_password_token", unique: true, using: :btree
  end

  create_table "stations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.bigint   "phone_number"
    t.bigint   "emergency_number"
    t.string   "token"
    t.string   "full_name"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "social_media"
    t.string   "social_id"
    t.string   "fcm_token"
    t.string   "type"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "vehicle_drivers", force: :cascade do |t|
    t.integer  "vehicle_id"
    t.integer  "driver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_vehicle_drivers_on_driver_id", using: :btree
    t.index ["vehicle_id"], name: "index_vehicle_drivers_on_vehicle_id", using: :btree
  end

  create_table "vehicles", force: :cascade do |t|
    t.string   "model_no"
    t.string   "registration_no",       null: false
    t.integer  "vehicle_type",          null: false
    t.string   "vehicle_number",        null: false
    t.string   "bus_type"
    t.string   "name"
    t.string   "vehicle_unique_number"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

end
