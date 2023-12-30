# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_12_16_124221) do
  create_table "people_finds", force: :cascade do |t|
    t.string "address"
    t.string "gender"
    t.integer "age"
    t.string "body_type"
    t.integer "height"
    t.string "race"
    t.string "facial_hair"
    t.string "voice"
    t.string "hair_color"
    t.string "ears"
    t.string "wrinkles"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "forehead"
    t.string "searcher_email"
    t.string "searcher_name"
    t.integer "users_id"
    t.index ["users_id"], name: "index_people_finds_on_users_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "remember_token"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  add_foreign_key "people_finds", "users", column: "users_id"
end
