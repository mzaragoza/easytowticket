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

ActiveRecord::Schema.define(version: 20131129222903) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.string   "name",          default: "",                           null: false
    t.string   "ticket_prefix", default: "",                           null: false
    t.string   "logo",          default: "",                           null: false
    t.string   "domain",        default: "",                           null: false
    t.string   "subdomain",     default: "",                           null: false
    t.string   "time_zone",     default: "Eastern Time (US & Canada)", null: false
    t.boolean  "active",        default: true,                         null: false
    t.boolean  "show_suppprt",  default: true,                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["domain"], name: "index_accounts_on_domain", unique: true, using: :btree
  add_index "accounts", ["name"], name: "index_accounts_on_name", unique: true, using: :btree
  add_index "accounts", ["subdomain"], name: "index_accounts_on_subdomain", unique: true, using: :btree

  create_table "admins", force: true do |t|
    t.integer  "account_id"
    t.string   "email",                  default: "",           null: false
    t.string   "encrypted_password",     default: "",           null: false
    t.string   "first_name",             default: "",           null: false
    t.string   "last_name",              default: "",           null: false
    t.string   "address",                default: "",           null: false
    t.string   "address2",               default: "",           null: false
    t.string   "city",                   default: "",           null: false
    t.string   "state",                  default: "",           null: false
    t.string   "zip_code",               default: "",           null: false
    t.string   "country",                default: "",           null: false
    t.string   "time_zone",              default: "",           null: false
    t.string   "phone",                  default: "",           null: false
    t.string   "occupation",             default: "",           null: false
    t.boolean  "active",                 default: true
    t.boolean  "is_owner",               default: false
    t.boolean  "is_admin",               default: false
    t.boolean  "is_driver",              default: false
    t.boolean  "newsletter",             default: true
    t.date     "start_date",             default: '2013-12-20'
    t.date     "end_date"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,            null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,            null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true, using: :btree
  add_index "admins", ["email", "account_id"], name: "index_admins_on_email_and_account_id", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  add_index "admins", ["unlock_token"], name: "index_admins_on_unlock_token", unique: true, using: :btree

  create_table "leads", force: true do |t|
    t.string   "first_name",      default: "",    null: false
    t.string   "last_name",       default: "",    null: false
    t.string   "email",           default: "",    null: false
    t.string   "message",         default: "",    null: false
    t.string   "phone",           default: "",    null: false
    t.string   "address",         default: "",    null: false
    t.string   "address2",        default: "",    null: false
    t.string   "city",            default: "",    null: false
    t.string   "state",           default: "",    null: false
    t.string   "zip",             default: "",    null: false
    t.string   "status",          default: "",    null: false
    t.string   "remoteip",        default: "",    null: false
    t.boolean  "newsletter",      default: false
    t.string   "conversion_date", default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", force: true do |t|
    t.string   "identification",                         default: ""
    t.integer  "account_id"
    t.integer  "created_by_id"
    t.integer  "requested_by_id"
    t.integer  "driver_id"
    t.integer  "truck_id"
    t.string   "location_of_viecle",                     default: ""
    t.string   "name",                                   default: ""
    t.string   "phone",                                  default: ""
    t.string   "address",                                default: ""
    t.string   "address2",                               default: ""
    t.string   "city",                                   default: ""
    t.string   "state",                                  default: ""
    t.string   "zip",                                    default: ""
    t.string   "license_number",                         default: ""
    t.integer  "milleage_finish"
    t.integer  "milleage_start"
    t.datetime "service_time_finish"
    t.datetime "service_time_start"
    t.datetime "extra_truck_finish"
    t.datetime "extra_truck_start"
    t.string   "car_year",                               default: ""
    t.string   "car_make",                               default: ""
    t.string   "car_model",                              default: ""
    t.string   "car_color",                              default: ""
    t.string   "vin_number",                             default: ""
    t.string   "tag_number",                             default: ""
    t.string   "tow_destination",                        default: ""
    t.string   "operators_comments",                     default: ""
    t.string   "status",                                 default: ""
    t.decimal  "milleage_charge"
    t.decimal  "towing_charge"
    t.decimal  "labor_charge"
    t.decimal  "storage_charge"
    t.decimal  "administration_fee"
    t.decimal  "tax"
    t.boolean  "sling",                                  default: false, null: false
    t.boolean  "hoist_tow",                              default: false, null: false
    t.boolean  "wheel_lift",                             default: false, null: false
    t.boolean  "flad_bed",                               default: false, null: false
    t.boolean  "start",                                  default: false, null: false
    t.boolean  "lock_out",                               default: false, null: false
    t.boolean  "flat_tire",                              default: false, null: false
    t.boolean  "out_of_gas",                             default: false, null: false
    t.boolean  "wreck",                                  default: false, null: false
    t.boolean  "recovery",                               default: false, null: false
    t.string   "other",                                  default: ""
    t.boolean  "special_equipment_single_line_winching", default: false, null: false
    t.boolean  "special_equipment_dual_line_winching",   default: false, null: false
    t.boolean  "special_equipment_snatch_blocks",        default: false, null: false
    t.boolean  "special_equipment_scotch_blocks",        default: false, null: false
    t.boolean  "special_equipment_dolly",                default: false, null: false
    t.string   "special_equipment_other",                default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
