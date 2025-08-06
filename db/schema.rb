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

ActiveRecord::Schema[7.1].define(version: 20250806012943) do
  create_table "articles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", null: false
    t.string "url", null: false
    t.text "description"
    t.string "author"
    t.date "publication_date"
    t.integer "estimated_read_time"
    t.integer "time_spent", default: 0
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "idx_articles_user_id"
  end

  create_table "books", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", null: false
    t.string "author", null: false
    t.text "description"
    t.string "isbn"
    t.string "genre"
    t.integer "total_pages"
    t.integer "current_page", default: 0
    t.integer "publication_year"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "idx_books_user_id"
    t.index ["status"], name: "idx_books_status"
  end

  create_table "calendar_events", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", null: false
    t.text "description"
    t.datetime "start_date", null: false
    t.datetime "end_date"
    t.integer "event_type", default: 0
    t.boolean "all_day", default: false
    t.string "eventable_type"
    t.integer "eventable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "idx_calendar_events_user_id"
  end

  create_table "chapters", force: :cascade do |t|
    t.integer "course_id"
    t.integer "book_id"
    t.string "title", null: false
    t.text "description"
    t.integer "order_number"
    t.boolean "completed", default: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", null: false
    t.text "description"
    t.string "instructor"
    t.string "platform"
    t.string "url"
    t.integer "status", default: 0
    t.date "start_date"
    t.date "target_completion_date"
    t.integer "total_duration_hours"
    t.string "difficulty_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "idx_courses_user_id"
    t.index ["status"], name: "idx_courses_status"
    t.index ["title"], name: "index_courses_on_title"
  end

  create_table "labs", force: :cascade do |t|
    t.integer "course_id", null: false
    t.string "title", null: false
    t.text "description"
    t.text "instructions"
    t.integer "order_number"
    t.boolean "completed", default: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", null: false
    t.text "content"
    t.string "notable_type"
    t.integer "notable_id"
    t.integer "parent_id"
    t.integer "position", default: 0
    t.boolean "is_folder", default: false
    t.string "color", default: "#3B82F6"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "idx_notes_user_id"
  end

  create_table "simple_todos", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.boolean "completed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "todos", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", null: false
    t.text "description"
    t.integer "priority"
    t.date "due_date"
    t.boolean "completed", default: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "idx_todos_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "videos", force: :cascade do |t|
    t.integer "course_id", null: false
    t.string "title", null: false
    t.text "description"
    t.string "url"
    t.integer "duration_minutes"
    t.integer "order_number"
    t.boolean "completed", default: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "articles", "users"
  add_foreign_key "books", "users"
  add_foreign_key "calendar_events", "users"
  add_foreign_key "courses", "users"
  add_foreign_key "notes", "users"
  add_foreign_key "todos", "users"
end
