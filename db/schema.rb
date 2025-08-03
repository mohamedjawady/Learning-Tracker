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

ActiveRecord::Schema[7.1].define(version: 2025_08_01_165708) do
  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.string "url"
    t.text "description"
    t.integer "status"
    t.integer "estimated_read_time"
    t.integer "time_spent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.text "description"
    t.string "isbn"
    t.integer "status"
    t.date "start_date"
    t.date "target_completion_date"
    t.integer "current_page"
    t.integer "total_pages"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "calendar_events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "event_type"
    t.boolean "all_day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "eventable_type"
    t.integer "eventable_id"
  end

  create_table "chapters", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "order_number"
    t.boolean "completed"
    t.datetime "completed_at"
    t.integer "course_id"
    t.integer "book_id"
    t.integer "page_start"
    t.integer "page_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_chapters_on_book_id"
    t.index ["course_id"], name: "index_chapters_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
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
    t.index ["status"], name: "index_courses_on_status"
    t.index ["title"], name: "index_courses_on_title"
  end

  create_table "labs", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "order_number"
    t.boolean "completed"
    t.datetime "completed_at"
    t.text "notes"
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_labs_on_course_id"
  end

  create_table "todos", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "priority"
    t.date "due_date"
    t.boolean "completed"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "order_number"
    t.integer "duration_minutes"
    t.integer "watched_minutes"
    t.boolean "completed"
    t.datetime "completed_at"
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_videos_on_course_id"
  end

  add_foreign_key "chapters", "books"
  add_foreign_key "chapters", "courses"
  add_foreign_key "labs", "courses"
  add_foreign_key "videos", "courses"
end
