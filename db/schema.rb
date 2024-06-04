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

ActiveRecord::Schema[7.1].define(version: 2024_06_04_090142) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_genres", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "genre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_book_genres_on_book_id"
    t.index ["genre_id"], name: "index_book_genres_on_genre_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.integer "serie_number"
    t.string "book_type"
    t.string "cover_url"
    t.text "description"
    t.string "isbn"
    t.date "release"
    t.string "author"
    t.string "illustrator"
    t.string "edition"
    t.string "illustrations"
    t.bigint "serie_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["serie_id"], name: "index_books_on_serie_id"
  end

  create_table "collections", force: :cascade do |t|
    t.boolean "is_read", default: false
    t.boolean "is_favorited", default: false
    t.text "comment"
    t.bigint "book_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_collections_on_book_id"
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "favorite_series", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "serie_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["serie_id"], name: "index_favorite_series_on_serie_id"
    t.index ["user_id"], name: "index_favorite_series_on_user_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "series", force: :cascade do |t|
    t.string "name"
    t.integer "books_total"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.boolean "public", default: false
    t.string "nickname"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "book_genres", "books"
  add_foreign_key "book_genres", "genres"
  add_foreign_key "books", "series", column: "serie_id"
  add_foreign_key "collections", "books"
  add_foreign_key "collections", "users"
  add_foreign_key "favorite_series", "series", column: "serie_id"
  add_foreign_key "favorite_series", "users"
end
