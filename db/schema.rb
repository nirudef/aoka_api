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

ActiveRecord::Schema[8.0].define(version: 2025_11_13_111817) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "article_translations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "article_id", null: false
    t.string "locale", null: false
    t.string "title", null: false
    t.text "lead"
    t.text "body", null: false
    t.string "meta_title"
    t.string "meta_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id", "locale"], name: "index_article_translations_on_article_id_and_locale", unique: true
  end

  create_table "articles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug", null: false
    t.string "status", default: "draft", null: false
    t.datetime "published_at"
    t.uuid "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_articles_on_category_id"
    t.index ["published_at"], name: "index_articles_on_published_at"
    t.index ["slug"], name: "index_articles_on_slug", unique: true
    t.index ["status"], name: "index_articles_on_status"
  end

  create_table "branch_translations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "branch_id"
    t.string "name"
    t.string "address"
    t.text "description"
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id", "locale"], name: "index_branch_translations_on_branch_id_and_locale", unique: true
    t.index ["branch_id"], name: "index_branch_translations_on_branch_id"
  end

  create_table "branches", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "phone"
    t.string "email"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.integer "position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_categories_on_key", unique: true
    t.index ["position"], name: "index_categories_on_position"
  end

  create_table "category_translations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "category_id", null: false
    t.string "locale", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id", "locale"], name: "index_category_translations_on_category_id_and_locale", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "law_office_translations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "law_office_id"
    t.string "name"
    t.string "address"
    t.text "description"
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["law_office_id", "locale"], name: "index_law_office_translations_on_law_office_id_and_locale", unique: true
    t.index ["law_office_id"], name: "index_law_office_translations_on_law_office_id"
  end

  create_table "law_offices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "phone"
    t.string "email"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "user_agent"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "verified", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.string "iin"
    t.string "phone"
    t.string "license_number"
    t.date "license_issued_at"
    t.date "joined_at"
    t.uuid "branch_id"
    t.uuid "law_office_id"
    t.string "address"
    t.jsonb "roles", default: []
    t.index ["branch_id"], name: "index_users_on_branch_id", where: "(branch_id IS NOT NULL)"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["iin"], name: "index_users_on_iin", unique: true
    t.index ["law_office_id"], name: "index_users_on_law_office_id", where: "(iin IS NOT NULL)"
  end

  add_foreign_key "article_translations", "articles", on_delete: :cascade
  add_foreign_key "articles", "categories", on_delete: :nullify
  add_foreign_key "branch_translations", "branches"
  add_foreign_key "category_translations", "categories", on_delete: :cascade
  add_foreign_key "sessions", "users"
  add_foreign_key "users", "branches"
end
