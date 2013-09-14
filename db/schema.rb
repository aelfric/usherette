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

ActiveRecord::Schema.define(:version => 20130914200243) do

  create_table "carts", :force => true do |t|
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.datetime "purchased_at"
    t.string   "order_firstname"
    t.string   "order_lastname"
    t.string   "order_email"
    t.datetime "placed_at"
    t.integer  "payment_type_cd", :default => 0
  end

  create_table "payment_notifications", :force => true do |t|
    t.text     "params"
    t.string   "status"
    t.string   "transaction_id"
    t.integer  "cart_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "performances", :force => true do |t|
    t.integer  "show_id"
    t.integer  "venue_id"
    t.datetime "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "price"
  end

  add_index "performances", ["show_id"], :name => "index_performances_on_show_id"
  add_index "performances", ["venue_id"], :name => "index_performances_on_venue_id"

  create_table "shows", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tickets", :force => true do |t|
    t.integer  "cart_id"
    t.integer  "performance_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "quantity",       :default => 1
  end

  add_index "tickets", ["cart_id"], :name => "index_tickets_on_cart_id"
  add_index "tickets", ["performance_id"], :name => "index_tickets_on_performance_id"

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
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.integer  "capacity"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end
