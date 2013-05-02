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

ActiveRecord::Schema.define(:version => 20130501161810) do

  create_table "attached_assets", :force => true do |t|
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.integer  "attachable_id"
    t.integer  "attachable_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "contracts", :force => true do |t|
    t.string   "city_rent",         :limit => 99
    t.date     "date_rent"
    t.string   "time_rent",         :limit => 5
    t.integer  "lease_time",        :limit => 2
    t.text     "body_contract"
    t.string   "contractor_mphone", :limit => 12
    t.string   "contractor_email",  :limit => 140
    t.string   "contractor_name",   :limit => 50
    t.boolean  "active",                           :default => false
    t.boolean  "close_contract",                   :default => false
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
    t.string   "t_car",             :limit => 30
  end

  add_index "contracts", ["active"], :name => "index_contracts_on_active"
  add_index "contracts", ["close_contract"], :name => "index_contracts_on_close_contract"
  add_index "contracts", ["date_rent", "active"], :name => "index_contracts_on_date_rent_and_active"
  add_index "contracts", ["t_car"], :name => "index_contracts_on_t_car"

  create_table "offers", :force => true do |t|
    t.integer  "contract_id"
    t.integer  "user_id"
    t.integer  "price"
    t.string   "adword"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "taken",       :default => false
  end

  add_index "offers", ["contract_id", "user_id"], :name => "index_offers_on_contract_id_and_user_id"
  add_index "offers", ["contract_id"], :name => "index_offers_on_contract_id"
  add_index "offers", ["taken"], :name => "index_offers_on_taken"
  add_index "offers", ["user_id"], :name => "index_offers_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "mphone"
    t.integer  "raiting"
    t.boolean  "admin"
    t.boolean  "moderator"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["mphone"], :name => "index_users_on_mphone", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
