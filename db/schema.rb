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

ActiveRecord::Schema.define(version: 20180109130546) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
  end

  create_table "coupons", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_active", default: true
  end

  create_table "leads", force: :cascade do |t|
    t.string "name"
    t.string "contact"
    t.string "email"
    t.bigint "plant_id"
    t.string "address"
    t.integer "quantity"
    t.integer "payment_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "location_id"
    t.integer "coupon_id"
    t.string "status", default: "Placed", null: false
    t.string "dedicate_type"
    t.string "dedicate_name"
    t.datetime "payment_date"
    t.string "comment"
    t.datetime "planted_date"
    t.boolean "archive", default: false
    t.index ["plant_id"], name: "index_leads_on_plant_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "type"
    t.string "lat"
    t.string "lng"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "current", default: 0, null: false
    t.integer "target", default: 1, null: false
    t.boolean "is_active", default: true
    t.string "optional_address"
    t.string "image"
  end

  create_table "plants", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.string "detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.boolean "is_available", default: true, null: false
  end

  create_table "products", force: :cascade do |t|
    t.bigint "sub_category_id"
    t.string "name"
    t.string "image"
    t.string "price"
    t.string "rating"
    t.string "description"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sub_category_id"], name: "index_products_on_sub_category_id"
  end

  create_table "sub_categories", force: :cascade do |t|
    t.bigint "category_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_sub_categories_on_category_id"
  end

  create_table "timeline_events", force: :cascade do |t|
    t.string "title"
    t.string "caption"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "location_id"
    t.bigint "lead_id"
    t.index ["location_id"], name: "index_timeline_events_on_location_id"
  end

  create_table "updates", force: :cascade do |t|
    t.bigint "lead_id"
    t.string "title"
    t.string "description"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lead_id"], name: "index_updates_on_lead_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "role"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "leads", "plants"
  add_foreign_key "products", "sub_categories"
  add_foreign_key "sub_categories", "categories"
  add_foreign_key "timeline_events", "locations"
  add_foreign_key "updates", "leads"
end
