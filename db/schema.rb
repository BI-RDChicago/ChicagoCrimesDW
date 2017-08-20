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

ActiveRecord::Schema.define(version: 20170820035329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dim_community_areas", force: :cascade do |t|
    t.integer  "source_id"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "dim_iucrs", force: :cascade do |t|
    t.text     "iucr_code"
    t.text     "primary_description"
    t.text     "secondary_description"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "dim_locations", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dim_times", force: :cascade do |t|
    t.date     "date"
    t.integer  "year"
    t.integer  "month"
    t.text     "monthname"
    t.integer  "day"
    t.integer  "dayofyear"
    t.text     "weekdayname"
    t.integer  "calendarweek"
    t.text     "formatteddate"
    t.text     "quartal"
    t.text     "yearquartal"
    t.text     "yearmonth"
    t.text     "yearcalendarweek"
    t.text     "weekend"
    t.text     "americanholiday"
    t.text     "austrianholiday"
    t.text     "canadianholiday"
    t.text     "period"
    t.date     "cwstart"
    t.date     "cwend"
    t.date     "monthstart"
    t.date     "monthend"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "fact_crimes", force: :cascade do |t|
    t.integer  "dim_community_areas_id"
    t.integer  "dim_times_id"
    t.integer  "dim_iucrs_id"
    t.integer  "dim_locations_id"
    t.integer  "quantity"
    t.integer  "arrest_qnt"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["dim_community_areas_id"], name: "index_fact_crimes_on_dim_community_areas_id", using: :btree
    t.index ["dim_iucrs_id"], name: "index_fact_crimes_on_dim_iucrs_id", using: :btree
    t.index ["dim_locations_id"], name: "index_fact_crimes_on_dim_locations_id", using: :btree
    t.index ["dim_times_id"], name: "index_fact_crimes_on_dim_times_id", using: :btree
  end

  add_foreign_key "fact_crimes", "dim_community_areas", column: "dim_community_areas_id"
  add_foreign_key "fact_crimes", "dim_iucrs", column: "dim_iucrs_id"
  add_foreign_key "fact_crimes", "dim_locations", column: "dim_locations_id"
  add_foreign_key "fact_crimes", "dim_times", column: "dim_times_id"
end
