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

ActiveRecord::Schema.define(version: 2018_11_30_171029) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "courses", force: :cascade do |t|
    t.bigint "school_id"
    t.string "name"
    t.text "description"
    t.string "url"
    t.string "course_type"
    t.string "commitment"
    t.integer "hours_per_week"
    t.string "start_date"
    t.integer "class_size"
    t.integer "duration_in_weeks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_courses_on_school_id"
  end

  create_table "locations", force: :cascade do |t|
    t.bigint "school_id"
    t.string "city"
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "county"
    t.string "state"
    t.string "postcode"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_locations_on_school_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "school_id"
    t.decimal "aggregate_rating"
    t.integer "review_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_ratings_on_school_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string "created_by"
    t.string "name"
    t.string "source_url"
    t.string "etag"
    t.text "about"
    t.string "website"
    t.string "email"
    t.boolean "job_guarantee"
    t.boolean "gi_bill"
    t.boolean "job_assistance"
    t.boolean "licensing"
    t.boolean "housing"
    t.boolean "corporate_training"
    t.boolean "closed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.bigint "course_id"
    t.string "name"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_subjects_on_course_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.bigint "school_id"
    t.string "name"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_tracks_on_school_id"
  end

  add_foreign_key "courses", "schools"
  add_foreign_key "locations", "schools"
  add_foreign_key "ratings", "schools"
  add_foreign_key "subjects", "courses"
  add_foreign_key "tracks", "schools"
end
