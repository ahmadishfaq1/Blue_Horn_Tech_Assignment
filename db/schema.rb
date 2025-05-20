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

ActiveRecord::Schema[7.1].define(version: 2025_05_16_213256) do
  create_table "caregivers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shifts", force: :cascade do |t|
    t.date "date"
    t.time "start_time"
    t.time "end_time"
    t.integer "caregiver_id", null: false
    t.integer "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["caregiver_id"], name: "index_shifts_on_caregiver_id"
    t.index ["client_id"], name: "index_shifts_on_client_id"
  end

  create_table "visit_logs", force: :cascade do |t|
    t.string "event_type"
    t.datetime "timestamp"
    t.float "latitude"
    t.float "longitude"
    t.integer "shift_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shift_id"], name: "index_visit_logs_on_shift_id"
  end

  add_foreign_key "shifts", "caregivers"
  add_foreign_key "shifts", "clients"
  add_foreign_key "visit_logs", "shifts"
end
