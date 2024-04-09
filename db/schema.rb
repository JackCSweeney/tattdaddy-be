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

ActiveRecord::Schema[7.1].define(version: 2024_04_09_172713) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artist_identities", force: :cascade do |t|
    t.bigint "artist_id", null: false
    t.bigint "identity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_artist_identities_on_artist_id"
    t.index ["identity_id"], name: "index_artist_identities_on_identity_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "identities", force: :cascade do |t|
    t.string "identity_label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tattoos", force: :cascade do |t|
    t.string "image_url"
    t.integer "price"
    t.integer "time_estimate"
    t.bigint "artist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_tattoos_on_artist_id"
  end

  create_table "user_identities", force: :cascade do |t|
    t.bigint "identity_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identity_id"], name: "index_user_identities_on_identity_id"
    t.index ["user_id"], name: "index_user_identities_on_user_id"
  end

  create_table "user_tattoos", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tattoo_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tattoo_id"], name: "index_user_tattoos_on_tattoo_id"
    t.index ["user_id"], name: "index_user_tattoos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "location"
    t.integer "search_radius"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "artist_identities", "artists"
  add_foreign_key "artist_identities", "identities"
  add_foreign_key "tattoos", "artists"
  add_foreign_key "user_identities", "identities"
  add_foreign_key "user_identities", "users"
  add_foreign_key "user_tattoos", "tattoos"
  add_foreign_key "user_tattoos", "users"
end
