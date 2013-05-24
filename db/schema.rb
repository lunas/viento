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

ActiveRecord::Schema.define(:version => 20130519230237) do

  create_table "clients", :force => true do |t|
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street"
    t.string   "company"
    t.string   "street_number"
    t.string   "zip"
    t.string   "country"
    t.string   "email"
    t.string   "phone_work"
    t.string   "phone_home"
    t.string   "phone_mobile"
    t.text     "notes"
    t.integer  "roles_mask"
    t.string   "profession"
    t.string   "first_name2"
    t.string   "last_name2"
    t.string   "street2"
    t.string   "status"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "city"
    t.integer  "sales_count"
    t.string   "mailing"
  end

  add_index "clients", ["city"], :name => "city_ix"
  add_index "clients", ["first_name"], :name => "first_name_ix"
  add_index "clients", ["last_name"], :name => "last_name_ix"
  add_index "clients", ["roles_mask"], :name => "roles_mask_ix"
  add_index "clients", ["status"], :name => "status_ix"
  add_index "clients", ["street"], :name => "street_ix"

  create_table "pieces", :force => true do |t|
    t.string   "name"
    t.string   "collection"
    t.string   "color"
    t.string   "fabric"
    t.integer  "size"
    t.integer  "count_produced"
    t.decimal  "price",          :precision => 10, :scale => 0
    t.decimal  "costs",          :precision => 10, :scale => 0
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.integer  "sales_count"
  end

  add_index "pieces", ["collection"], :name => "collection_ix"
  add_index "pieces", ["color"], :name => "color_ix"
  add_index "pieces", ["count_produced"], :name => "count_produced_ix"
  add_index "pieces", ["fabric"], :name => "fabric_ix"
  add_index "pieces", ["name"], :name => "name_ix"
  add_index "pieces", ["price"], :name => "price_ix"
  add_index "pieces", ["size"], :name => "size_ix"

  create_table "sales", :force => true do |t|
    t.integer  "client_id"
    t.integer  "piece_id"
    t.date     "date"
    t.decimal  "actual_price", :precision => 10, :scale => 0
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "sales", ["actual_price"], :name => "actual_price_ix"
  add_index "sales", ["client_id"], :name => "client_id_ix"
  add_index "sales", ["date"], :name => "date_ix"
  add_index "sales", ["piece_id"], :name => "piece_id_ix"

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
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "authentication_token"
    t.string   "username"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "roles_mask"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
