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

ActiveRecord::Schema.define(:version => 20111204184200) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "arts", :force => true do |t|
    t.string   "name",                     :default => ""
    t.boolean  "template",                 :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "club_id",     :limit => 8
    t.integer  "template_id", :limit => 8
    t.boolean  "enabled",                  :default => true, :null => false
  end

  create_table "arts_grades", :id => false, :force => true do |t|
    t.integer  "art_id",     :limit => 8, :default => 0, :null => false
    t.integer  "grade_id",   :limit => 8, :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clubs", :force => true do |t|
    t.string   "title",                          :default => "", :null => false
    t.text     "description"
    t.text     "schedule"
    t.string   "address",                        :default => "", :null => false
    t.string   "zip",                            :default => "", :null => false
    t.string   "town",                           :default => "", :null => false
    t.string   "country",                        :default => "", :null => false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.string   "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "accessibility"
    t.text     "contact"
    t.integer  "owner_id",          :limit => 8, :default => 0,  :null => false
  end

  add_index "clubs", ["country"], :name => "index_clubs_on_country"
  add_index "clubs", ["title"], :name => "index_clubs_on_title"
  add_index "clubs", ["town"], :name => "index_clubs_on_town"

  create_table "countries", :force => true do |t|
    t.string  "iso"
    t.string  "name"
    t.string  "printable_name"
    t.string  "iso3"
    t.integer "numcode"
  end

  create_table "course_history", :force => true do |t|
    t.integer  "user_id",     :limit => 8
    t.integer  "club_id",     :limit => 8
    t.datetime "course_date"
  end

  create_table "grades", :force => true do |t|
    t.string   "name",                 :default => ""
    t.integer  "grade_order",          :default => 0
    t.boolean  "template",             :default => true
    t.string   "language",             :default => "en"
    t.integer  "age_minimum",          :default => 0
    t.boolean  "is_presence_required", :default => true
    t.integer  "presence_required"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", :force => true do |t|
    t.string "firstname", :limit => 50, :default => "", :null => false
    t.string "lastname",  :limit => 50, :default => "", :null => false
    t.date   "birthdate"
    t.string "email",     :limit => 80
    t.string "phone",     :limit => 50
  end

  create_table "members_clubs", :force => true do |t|
    t.integer  "member_id",                             :null => false
    t.integer  "club_id",                               :null => false
    t.datetime "member_since"
    t.integer  "presence",            :default => 0,    :null => false
    t.boolean  "is_licence_ok",       :default => true, :null => false
    t.datetime "licence_end_date"
    t.boolean  "is_insurance_ok",     :default => true, :null => false
    t.datetime "insuruance_end_date"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "members_clubs_old", :primary_key => "member_id", :force => true do |t|
    t.integer  "club_id",      :limit => 8, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "member_since"
    t.integer  "presence"
  end

  create_table "plans", :force => true do |t|
    t.string   "title",                           :null => false
    t.float    "monthly_fees", :default => 0.0
    t.float    "yearly_fees",  :default => 0.0
    t.string   "currency",                        :null => false
    t.boolean  "is_active",    :default => false, :null => false
    t.string   "description",                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.integer  "project_id"
    t.integer  "admin_user_id"
    t.string   "title"
    t.boolean  "is_done"
    t.date     "due_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "firstname",          :limit => 50
    t.string   "lastname",           :limit => 50
    t.string   "username",           :limit => 20
    t.string   "email",              :limit => 50
    t.string   "address"
    t.string   "town"
    t.string   "zip",                :limit => 20
    t.string   "country"
    t.string   "language",           :limit => 4
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "crypted_password",                                :null => false
    t.string   "password_salt",                                   :null => false
    t.string   "persistence_token",                               :null => false
    t.string   "perishable_token",                                :null => false
    t.integer  "login_count",                      :default => 0
    t.integer  "failed_login_count",               :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
  end

  create_table "users_clubs", :id => false, :force => true do |t|
    t.integer  "user_id",    :limit => 8, :default => 0, :null => false
    t.integer  "club_id",    :limit => 8, :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
