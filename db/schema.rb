# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_05_130658) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "families", force: :cascade do |t|
    t.string "name"
    t.integer "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "house_users", id: false, force: :cascade do |t|
    t.bigint "house_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "houses", force: :cascade do |t|
    t.string "name"
    t.integer "score"
    t.bigint "family_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["family_id"], name: "index_houses_on_family_id"
  end

  create_table "my_tasks", force: :cascade do |t|
    t.bigint "house_id", null: false
    t.bigint "task_id", null: false
    t.integer "progress"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["house_id"], name: "index_my_tasks_on_house_id"
    t.index ["task_id"], name: "index_my_tasks_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.integer "score"
    t.text "description"
    t.integer "publicity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "difficulty"
    t.integer "age"
    t.bigint "suggested_id"
    t.string "lang"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "username"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role"
    t.string "locale"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "houses", "families"
  add_foreign_key "my_tasks", "houses"
  add_foreign_key "my_tasks", "tasks"
end
