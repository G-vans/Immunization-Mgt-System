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

ActiveRecord::Schema[7.1].define(version: 2024_03_23_092846) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "children", force: :cascade do |t|
    t.string "baby_name"
    t.string "parent_name"
    t.date "date_of_birth"
    t.string "gender"
    t.string "phone_number"
    t.integer "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "language"
  end

  create_table "educational_messages", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "category"
    t.string "duration"
    t.bigint "medic_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medic_id"], name: "index_educational_messages_on_medic_id"
  end

  create_table "immunization_schedules", force: :cascade do |t|
    t.string "vaxx_name"
    t.date "scheduled_date"
    t.bigint "child_id", null: false
    t.bigint "medic_id", null: false
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_immunization_schedules_on_child_id"
    t.index ["medic_id"], name: "index_immunization_schedules_on_medic_id"
  end

  create_table "medics", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_medics_on_email", unique: true
    t.index ["reset_password_token"], name: "index_medics_on_reset_password_token", unique: true
  end

  create_table "vaccines", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "educational_messages", "medics"
  add_foreign_key "immunization_schedules", "children"
  add_foreign_key "immunization_schedules", "medics"
end
