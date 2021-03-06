# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091002224034) do

  create_table "cards", :force => true do |t|
    t.string   "name"
    t.string   "cardtype"
    t.string   "mtg_id"
    t.string   "cc"
    t.integer  "cmc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "decks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identifiers", :force => true do |t|
    t.string   "provider"
    t.string   "ident"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "runs", :force => true do |t|
    t.integer "card_id"
    t.integer "deck_id"
    t.integer "count"
    t.string  "pile"
  end

  create_table "users", :force => true do |t|
    t.string "display_name"
  end

end
