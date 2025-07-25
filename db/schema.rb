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

ActiveRecord::Schema[8.0].define(version: 2025_07_04_222915) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "instruction_clicks", force: :cascade do |t|
    t.bigint "instruction_id", null: false
    t.bigint "user_id", null: false
    t.datetime "clicked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instruction_id"], name: "index_instruction_clicks_on_instruction_id"
    t.index ["user_id"], name: "index_instruction_clicks_on_user_id"
  end

  create_table "instructions", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "link"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_instructions_on_user_id"
  end

  create_table "link_views", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "link_id", null: false
    t.datetime "viewed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["link_id"], name: "index_link_views_on_link_id"
    t.index ["user_id"], name: "index_link_views_on_user_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "url"
    t.bigint "admin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "visit_count"
    t.decimal "revenue_amount"
    t.decimal "value"
    t.index ["admin_id"], name: "index_links_on_admin_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "balance", precision: 30, scale: 10, default: "0.0"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "instruction_clicks", "instructions"
  add_foreign_key "instruction_clicks", "users"
  add_foreign_key "instructions", "users"
  add_foreign_key "link_views", "links"
  add_foreign_key "link_views", "users"
  add_foreign_key "links", "admins"
end
