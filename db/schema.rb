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

ActiveRecord::Schema[8.1].define(version: 2026_09_06_115255) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "tokens", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.text "example"
    t.boolean "lang_css"
    t.boolean "lang_html"
    t.boolean "lang_javascript"
    t.boolean "lang_other"
    t.boolean "lang_rails"
    t.boolean "lang_ruby"
    t.text "memo"
    t.text "translation"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "password"
    t.string "password_confirmation"
    t.string "password_digest"
    t.datetime "updated_at", null: false
  end
end
