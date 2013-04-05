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

ActiveRecord::Schema.define(:version => 20130404152722) do

  create_table "heating_logs", :force => true do |t|
    t.integer  "room_id"
    t.boolean  "heating"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "history", :force => true do |t|
    t.integer  "opening_id"
    t.integer  "room_id"
    t.integer  "home_id"
    t.float    "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "homes", :force => true do |t|
    t.boolean  "mode_auto"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "opening_measures", :force => true do |t|
    t.integer  "opening_id"
    t.boolean  "opened"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "openings", :force => true do |t|
    t.boolean  "opened"
    t.text     "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "home_id"
    t.integer  "gpio_number"
  end

  create_table "openings_rooms", :id => false, :force => true do |t|
    t.integer "opening_id"
    t.integer "room_id"
  end

  create_table "rooms", :force => true do |t|
    t.boolean  "heating"
    t.boolean  "light"
    t.text     "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "home_id"
    t.float    "temperature"
    t.boolean  "isoutside"
  end

  create_table "temperature_measures", :force => true do |t|
    t.integer  "room_id"
    t.float    "temperature"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password"
    t.string   "email"
    t.integer  "role"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
