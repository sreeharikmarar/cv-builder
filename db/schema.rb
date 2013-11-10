# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130913093344) do

  create_table "education_details", :force => true do |t|
    t.integer "user_id"
    t.string  "degree"
    t.string  "field_of_study"
    t.string  "school_name"
    t.string  "start_date"
    t.string  "end_date"
  end

  create_table "github_details", :force => true do |t|
    t.integer  "user_id"
    t.string   "project_name"
    t.string   "project_description"
    t.string   "public_url"
    t.string   "contribution",        :limit => 1000
    t.string   "technologies"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  create_table "keywords", :force => true do |t|
    t.integer "user_id"
    t.string  "type"
    t.string  "name"
  end

  create_table "linkedin_details", :force => true do |t|
    t.integer "user_id"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "email"
    t.string  "headline"
    t.string  "location"
    t.string  "year"
    t.string  "month"
    t.string  "day"
    t.string  "phone_number"
    t.string  "main_address"
    t.string  "twitter_account"
    t.string  "public_profile_url"
    t.string  "personal_website"
  end

  create_table "positions", :force => true do |t|
    t.integer "user_id"
    t.string  "title"
    t.string  "company_name"
    t.string  "industry_name"
    t.boolean "is_current",                    :default => false
    t.string  "start_date"
    t.string  "end_date"
    t.string  "summary",       :limit => 1000
  end

  create_table "projects", :force => true do |t|
    t.integer  "user_id"
    t.string   "project_name"
    t.text     "project_description"
    t.string   "public_url"
    t.text     "contribution"
    t.string   "technologies"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "share_cvs", :force => true do |t|
    t.integer "user_id"
    t.string  "url"
    t.string  "theme"
    t.boolean "publish", :default => true
  end

  create_table "technical_details", :force => true do |t|
    t.integer "user_id"
    t.text    "details", :limit => 16777215
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "image"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
