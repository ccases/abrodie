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

ActiveRecord::Schema.define(version: 2022_01_21_065914) do

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: 6, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "fname"
    t.string "lname"
    t.string "contact_no"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_admins_on_user_id"
  end

  create_table "agencies", force: :cascade do |t|
    t.boolean "verified", default: false
    t.string "kind"
    t.datetime "license_validity", precision: 6
    t.string "contact_no"
    t.string "address"
    t.float "average_rating", default: 0.0
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_agencies_on_user_id"
  end

  create_table "applicants", force: :cascade do |t|
    t.string "specialization"
    t.text "resume"
    t.string "educational_level"
    t.float "experience"
    t.string "fname"
    t.string "lname"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.datetime "birth_date", precision: 6
    t.index ["user_id"], name: "index_applicants_on_user_id"
  end

  create_table "applications", force: :cascade do |t|
    t.float "expected_salary"
    t.string "status", default: "processing"
    t.text "resume"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "applicant_id", null: false
    t.integer "job_id", null: false
    t.index ["applicant_id"], name: "index_applications_on_applicant_id"
    t.index ["job_id"], name: "index_applications_on_job_id"
  end

  create_table "branches", force: :cascade do |t|
    t.text "location"
    t.string "email_ad"
    t.string "contact_no"
    t.integer "agency_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["agency_id"], name: "index_branches_on_agency_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories_jobs", id: false, force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "job_id", null: false
    t.index ["category_id", "job_id"], name: "index_categories_jobs_on_category_id_and_job_id"
    t.index ["job_id", "category_id"], name: "index_categories_jobs_on_job_id_and_category_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.text "desc"
    t.string "title"
    t.float "salary"
    t.string "level"
    t.string "location"
    t.boolean "salary_hidden", default: true
    t.integer "vacancies", default: 1
    t.boolean "vacancies_hidden", default: true
    t.string "employer"
    t.integer "agency_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["agency_id"], name: "index_jobs_on_agency_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating", default: 0
    t.text "body"
    t.integer "applicant_id", null: false
    t.integer "agency_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["agency_id"], name: "index_reviews_on_agency_id"
    t.index ["applicant_id"], name: "index_reviews_on_applicant_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admins", "users"
  add_foreign_key "agencies", "users"
  add_foreign_key "applicants", "users"
  add_foreign_key "applications", "applicants"
  add_foreign_key "applications", "jobs"
  add_foreign_key "branches", "agencies"
  add_foreign_key "reviews", "agencies"
  add_foreign_key "reviews", "applicants"
end
