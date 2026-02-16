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

ActiveRecord::Schema[7.2].define(version: 2026_02_16_110217) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "name_fr"
    t.string "iso_code", limit: 3
    t.string "slug"
    t.string "continent"
    t.string "region"
    t.string "cat_rating"
    t.string "cat_policies_rating"
    t.string "cat_ndc_rating"
    t.string "cat_fair_share_rating"
    t.float "emissions_per_capita"
    t.float "total_emissions_mt"
    t.float "emissions_trend_pct"
    t.integer "renewable_energy_pct"
    t.float "ccpi_score"
    t.integer "ccpi_rank"
    t.float "climate_score"
    t.float "local_impact_score"
    t.float "biodiversity_score"
    t.boolean "paris_agreement_signed"
    t.boolean "paris_agreement_ratified"
    t.date "paris_ratification_date"
    t.text "ndc_summary"
    t.float "tourism_gdp_pct"
    t.integer "protected_areas_pct"
    t.string "flag_emoji"
    t.text "description"
    t.text "description_fr"
    t.string "capital"
    t.float "latitude"
    t.float "longitude"
    t.date "data_last_updated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "destinations", force: :cascade do |t|
    t.bigint "country_id", null: false
    t.string "name"
    t.string "slug"
    t.string "region"
    t.text "description"
    t.text "description_fr"
    t.float "latitude"
    t.float "longitude"
    t.integer "green_accommodations_count"
    t.integer "eco_certifications_count"
    t.boolean "accessible_by_train"
    t.string "nearest_train_station"
    t.float "local_impact_score"
    t.string "tourism_pressure"
    t.integer "annual_visitors"
    t.boolean "featured"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_destinations_on_country_id"
  end

  create_table "transport_modes", force: :cascade do |t|
    t.string "name"
    t.string "name_fr"
    t.string "icon"
    t.float "co2_per_km"
    t.float "co2_per_km_short"
    t.float "co2_per_km_long"
    t.string "source"
    t.integer "comfort_score"
    t.integer "speed_score"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trips", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "destination_id"
    t.bigint "country_id", null: false
    t.bigint "transport_mode_id", null: false
    t.string "origin_city"
    t.string "origin_country_iso", limit: 3
    t.float "origin_latitude"
    t.float "origin_longitude"
    t.float "distance_km"
    t.integer "duration_days"
    t.integer "travelers_count"
    t.date "departure_date"
    t.date "return_date"
    t.float "co2_transport_kg"
    t.float "co2_accommodation_kg"
    t.float "co2_total_kg"
    t.float "co2_per_day_kg"
    t.float "climate_country_score"
    t.float "transport_score"
    t.float "local_impact_score"
    t.float "overall_score"
    t.string "grade"
    t.text "recommendations"
    t.integer "climate_weight_used"
    t.integer "transport_weight_used"
    t.integer "local_impact_weight_used"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_trips_on_country_id"
    t.index ["destination_id"], name: "index_trips_on_destination_id"
    t.index ["transport_mode_id"], name: "index_trips_on_transport_mode_id"
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "home_city"
    t.string "home_country_iso"
    t.float "home_latitude"
    t.float "home_longitude"
    t.string "preferred_transport"
    t.string "scoring_priority"
    t.integer "climate_weight"
    t.integer "transport_weight"
    t.integer "local_impact_weight"
    t.float "total_co2_saved"
    t.integer "trips_count"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "destinations", "countries"
  add_foreign_key "trips", "countries"
  add_foreign_key "trips", "destinations"
  add_foreign_key "trips", "transport_modes"
  add_foreign_key "trips", "users"
end
