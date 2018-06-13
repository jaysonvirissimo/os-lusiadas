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

ActiveRecord::Schema.define(version: 20180613043733) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authem_sessions", force: :cascade do |t|
    t.string "role", null: false
    t.string "subject_type", null: false
    t.bigint "subject_id", null: false
    t.string "token", limit: 60, null: false
    t.datetime "expires_at", null: false
    t.integer "ttl", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expires_at", "subject_type", "subject_id"], name: "index_authem_sessions_subject"
    t.index ["expires_at", "token"], name: "index_authem_sessions_on_expires_at_and_token", unique: true
    t.index ["subject_type", "subject_id"], name: "index_authem_sessions_on_subject_type_and_subject_id"
  end

  create_table "cantos", force: :cascade do |t|
    t.integer "number"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lines", force: :cascade do |t|
    t.bigint "stanza_id"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "absolute_number"
    t.string "in_english"
    t.index ["stanza_id"], name: "index_lines_on_stanza_id"
  end

  create_table "okubo_decks", id: :serial, force: :cascade do |t|
    t.string "user_type"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id", "user_type"], name: "index_okubo_decks_on_user_id_and_user_type"
  end

  create_table "okubo_items", id: :serial, force: :cascade do |t|
    t.integer "deck_id"
    t.string "source_type"
    t.integer "source_id"
    t.integer "box", default: 0
    t.datetime "last_reviewed"
    t.datetime "next_review"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "times_right", default: 0
    t.integer "times_wrong", default: 0
    t.index ["source_id", "source_type"], name: "index_okubo_items_on_source_id_and_source_type"
  end

  create_table "stanzas", force: :cascade do |t|
    t.integer "number"
    t.bigint "canto_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["canto_id"], name: "index_stanzas_on_canto_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "name", null: false
    t.string "password_digest", null: false
    t.string "password_reset_token", limit: 60, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "read_translation", default: true
  end

  create_table "words", force: :cascade do |t|
    t.bigint "line_id"
    t.string "value"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "absolute_position"
    t.index ["line_id"], name: "index_words_on_line_id"
  end

  add_foreign_key "lines", "stanzas"
  add_foreign_key "stanzas", "cantos"
  add_foreign_key "words", "lines"
end
