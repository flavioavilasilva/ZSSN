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

ActiveRecord::Schema[7.0].define(version: 2023_03_29_150825) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "infected_alerts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "warned_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_infected_alerts_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.integer "age"
    t.string "gender"
    t.string "latitude"
    t.string "longitude"
    t.boolean "infected", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "infected_alerts", "users"
  add_foreign_key "infected_alerts", "users", column: "warned_by_id"
  add_foreign_key "items", "users"
end
