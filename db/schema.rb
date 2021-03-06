# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_24_011820) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "armor", force: :cascade do |t|
    t.string "name"
    t.string "armor_type"
    t.integer "ac"
    t.integer "strength_requirement"
    t.boolean "stealth_disadvantage"
    t.integer "weight"
    t.integer "value"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "conditions", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "magic_items", force: :cascade do |t|
    t.string "name"
    t.boolean "wondrous"
    t.float "weight"
    t.string "tier"
    t.string "rarity"
    t.string "attunement"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "item_type"
  end

  create_table "monsters", force: :cascade do |t|
    t.string "name"
    t.string "size"
    t.string "monster_type"
    t.string "alignment"
    t.string "ac"
    t.integer "hp"
    t.string "hp_formula"
    t.string "speed"
    t.integer "strength"
    t.integer "dexterity"
    t.integer "constitution"
    t.integer "intelligence"
    t.integer "wisdom"
    t.integer "charisma"
    t.string "saving_throws"
    t.string "skills"
    t.string "damage_resistances"
    t.string "damage_immunities"
    t.string "condition_immunities"
    t.string "senses"
    t.string "languages"
    t.string "challenge"
    t.string "traits"
    t.string "actions"
    t.string "legendary_actions"
    t.string "spellcasting"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "spells", force: :cascade do |t|
    t.string "name"
    t.integer "level"
    t.string "school"
    t.string "casting_time"
    t.string "range"
    t.boolean "verbal"
    t.boolean "somatic"
    t.string "material"
    t.string "duration"
    t.string "description"
    t.string "source"
    t.string "classes"
    t.boolean "ritual"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "weapon_properties", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "weapon_properties_weapons", id: false, force: :cascade do |t|
    t.integer "weapon_id", null: false
    t.integer "weapon_property_id", null: false
  end

  create_table "weapons", force: :cascade do |t|
    t.string "name"
    t.string "weapon_type"
    t.string "damage_type"
    t.string "damage"
    t.string "two_handed_damage"
    t.string "category"
    t.integer "value"
    t.integer "weight"
    t.string "range"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
