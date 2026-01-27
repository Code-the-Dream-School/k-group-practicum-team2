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

ActiveRecord::Schema[8.1].define(version: 2026_01_23_211157) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bookmarked_projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "project_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["project_id"], name: "index_bookmarked_projects_on_project_id"
    t.index ["user_id"], name: "index_bookmarked_projects_on_user_id"
  end

  create_table "bookmarked_resources", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "resource_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["resource_id"], name: "index_bookmarked_resources_on_resource_id"
    t.index ["user_id"], name: "index_bookmarked_resources_on_user_id"
  end

  create_table "profile_skills", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "profile_id", null: false
    t.integer "skill_id", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_profile_skills_on_profile_id"
    t.index ["skill_id"], name: "index_profile_skills_on_skill_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.text "bio"
    t.datetime "created_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "skill_level", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "project_skills", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "project_id", null: false
    t.integer "skill_id", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_skills_on_project_id"
    t.index ["skill_id"], name: "index_project_skills_on_skill_id"
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "status", default: 0, null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "resources", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "title"
    t.datetime "updated_at", null: false
    t.string "url"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_resources_on_user_id"
  end

  create_table "skills", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookmarked_projects", "projects"
  add_foreign_key "bookmarked_projects", "users"
  add_foreign_key "bookmarked_resources", "resources"
  add_foreign_key "bookmarked_resources", "users"
  add_foreign_key "profile_skills", "profiles"
  add_foreign_key "profile_skills", "skills"
  add_foreign_key "profiles", "users"
  add_foreign_key "project_skills", "projects"
  add_foreign_key "project_skills", "skills"
  add_foreign_key "projects", "users"
  add_foreign_key "resources", "users"
end
