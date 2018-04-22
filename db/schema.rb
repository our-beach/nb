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

ActiveRecord::Schema.define(version: 20180422232422) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auth_codes", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "data_encryption_keys", force: :cascade do |t|
    t.string "encrypted_key", null: false
    t.boolean "primary", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_key_iv"
  end

  create_table "encrypted_fields", force: :cascade do |t|
    t.string "encrypted_blob"
    t.string "encrypted_blob_iv"
    t.string "encrypted_blob_salt"
    t.bigint "data_encryption_key_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_encryption_key_id"], name: "index_encrypted_fields_on_data_encryption_key_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "encrypted_fields", "data_encryption_keys"
end
