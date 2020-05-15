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

ActiveRecord::Schema.define(version: 2020_05_08_071859) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "short_description"
    t.text "description"
    t.integer "category_type_id"
    t.index ["category_type_id"], name: "index_categories_on_category_type_id"
  end

  create_table "category_types", id: :serial, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "checksheet_answers", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.boolean "correct_answer", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "answer"
    t.integer "video_id"
    t.index ["user_id"], name: "index_checksheet_answers_on_user_id"
    t.index ["video_id"], name: "index_checksheet_answers_on_video_id"
  end

  create_table "checksheets", id: :serial, force: :cascade do |t|
    t.string "question"
    t.string "choice_a"
    t.string "choice_b"
    t.string "choice_c"
    t.string "choice_d"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "answer_type"
    t.string "correct"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.integer "video_id"
    t.integer "user_id"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_comments_on_user_id"
    t.index ["video_id"], name: "index_comments_on_video_id"
  end

  create_table "last_questionnaire_answers", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.json "answer"
    t.boolean "post_completion", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "progresses", id: :serial, force: :cascade do |t|
    t.integer "video_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_progresses_on_user_id"
    t.index ["video_id"], name: "index_progresses_on_video_id"
  end

  create_table "questionnaire_answers", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "category_id"
    t.json "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "post_completion"
  end

  create_table "questionnaires", id: :serial, force: :cascade do |t|
    t.integer "category_id"
    t.string "question"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "choice_a"
    t.string "choice_b"
    t.string "choice_c"
    t.string "choice_d"
    t.string "question_type"
    t.integer "order"
    t.index ["category_id"], name: "index_questionnaires_on_category_id"
  end

  create_table "self_checks", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "category_id"
    t.json "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_self_checks_on_category_id"
    t.index ["user_id"], name: "index_self_checks_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.boolean "administrator", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "crypted_password"
    t.string "salt"
  end

  create_table "video_checksheets", id: :serial, force: :cascade do |t|
    t.integer "video_id"
    t.integer "checksheet_id"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["checksheet_id"], name: "index_video_checksheets_on_checksheet_id"
    t.index ["video_id"], name: "index_video_checksheets_on_video_id"
  end

  create_table "videos", id: :serial, force: :cascade do |t|
    t.integer "category_id"
    t.string "videofile_file_name"
    t.string "videofile_content_type"
    t.bigint "videofile_file_size"
    t.datetime "videofile_updated_at"
    t.text "description", null: false
    t.string "worksheet_file_name"
    t.string "worksheet_content_type"
    t.bigint "worksheet_file_size"
    t.datetime "worksheet_updated_at"
    t.string "slide_file_name"
    t.string "slide_content_type"
    t.bigint "slide_file_size"
    t.datetime "slide_updated_at"
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
    t.string "thumbnail_file_name"
    t.string "thumbnail_content_type"
    t.bigint "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
    t.integer "minutes"
    t.integer "seconds"
    t.index ["category_id"], name: "index_videos_on_category_id"
  end

  add_foreign_key "checksheet_answers", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "comments", "videos"
  add_foreign_key "progresses", "users"
  add_foreign_key "progresses", "videos"
  add_foreign_key "questionnaires", "categories"
  add_foreign_key "self_checks", "categories"
  add_foreign_key "self_checks", "users"
  add_foreign_key "video_checksheets", "checksheets"
  add_foreign_key "video_checksheets", "videos"
end
