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

ActiveRecord::Schema.define(version: 20131125021519) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.string   "name",       default: "",   null: false
    t.string   "domain",     default: "",   null: false
    t.boolean  "active",     default: true, null: false
    t.string   "subdomain",  default: "",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["domain"], name: "index_accounts_on_domain", unique: true, using: :btree
  add_index "accounts", ["name"], name: "index_accounts_on_name", unique: true, using: :btree
  add_index "accounts", ["subdomain"], name: "index_accounts_on_subdomain", unique: true, using: :btree

  create_table "admins", force: true do |t|
    t.integer  "account_id"
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "first_name",             default: "",   null: false
    t.string   "last_name",              default: "",   null: false
    t.string   "address",                default: "",   null: false
    t.string   "address2",               default: "",   null: false
    t.string   "city",                   default: "",   null: false
    t.string   "state",                  default: "",   null: false
    t.string   "zip_code",               default: "",   null: false
    t.string   "country",                default: "",   null: false
    t.string   "time_zone",              default: "",   null: false
    t.string   "phone",                  default: "",   null: false
    t.string   "occupation",             default: "",   null: false
    t.boolean  "active",                 default: true
    t.boolean  "newsletter",             default: true
    t.date     "birthday"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,    null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true, using: :btree
  add_index "admins", ["email", "account_id"], name: "index_admins_on_email_and_account_id", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  add_index "admins", ["unlock_token"], name: "index_admins_on_unlock_token", unique: true, using: :btree

end
