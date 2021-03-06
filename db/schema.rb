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

ActiveRecord::Schema.define(version: 20180225203138) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "other_text"
  end

  create_table "employees", force: :cascade do |t|
    t.boolean "employee"
    t.text "first_name"
    t.text "last_name"
    t.text "middle_initial"
    t.text "job_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "email", default: "", null: false
    t.text "encrypted_password", default: "", null: false
    t.text "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.text "current_sign_in_ip"
    t.text "last_sign_in_ip"
    t.integer "role"
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
  end

  create_table "external_action_authorizations", force: :cascade do |t|
    t.text "authorization_code"
    t.integer "system_access_request_id"
    t.integer "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.text "name"
    t.integer "group_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resources", force: :cascade do |t|
    t.text "name"
    t.text "url"
    t.integer "resource_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "signatures", force: :cascade do |t|
    t.integer "signature_type"
    t.integer "system_access_request_id"
    t.text "signature"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submitter_id"
  end

  create_table "software_roles", force: :cascade do |t|
    t.integer "software_id"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "softwares", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "system_access_fields", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "system_access_request_departments", force: :cascade do |t|
    t.integer "system_access_request_id"
    t.integer "department_id"
    t.text "other_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "system_access_request_groups", force: :cascade do |t|
    t.integer "system_access_request_id"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "system_access_request_softwares", force: :cascade do |t|
    t.integer "system_access_request_id"
    t.integer "software_id"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "system_access_request_system_access_fields", force: :cascade do |t|
    t.integer "system_access_request_id"
    t.integer "system_access_field_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "system_access_requests", force: :cascade do |t|
    t.date "effective_date"
    t.integer "employee_id"
    t.text "reason"
    t.text "privileged_access"
    t.text "business_justification"
    t.text "special_instructions"
    t.text "other_access"
    t.text "sales_rep_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state"
  end

end
