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

ActiveRecord::Schema.define(version: 2021_08_06_092125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.integer "workspace_id"
    t.string "name"
    t.integer "bill_type"
    t.float "amount"
    t.float "actual_amount"
    t.integer "cargo_category_id"
    t.integer "count"
    t.date "billed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "tag"
  end

  create_table "cargo_categories", force: :cascade do |t|
    t.integer "cargo_id"
    t.string "name"
    t.float "price"
    t.integer "count", default: 0
    t.text "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "photo"
    t.integer "parent_id"
    t.integer "level", default: 0
    t.integer "tag_id"
  end

  create_table "cargoes", force: :cascade do |t|
    t.integer "workspace_id"
    t.string "name"
    t.float "price"
    t.text "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_workspace_requests", force: :cascade do |t|
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "workspace_id"
  end

  create_table "user_workspaces", force: :cascade do |t|
    t.integer "workspace_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "nickname"
    t.string "avatar"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wechat_users", force: :cascade do |t|
    t.string "open_id"
    t.string "nickname"
    t.string "avatar_url"
    t.integer "gender"
    t.string "language"
    t.string "country"
    t.string "province"
    t.string "city"
    t.text "raw_data"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "workspace_tags", force: :cascade do |t|
    t.integer "workspace_id"
    t.integer "tag_type"
    t.string "name"
    t.text "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "workspaces", force: :cascade do |t|
    t.integer "creator_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
