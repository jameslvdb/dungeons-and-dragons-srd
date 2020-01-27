class CreateMonsters < ActiveRecord::Migration[6.0]
  def change
    create_table :monsters do |t|
      t.string :name
      t.string :size
      t.string :monster_type
      t.string :ac
      t.integer :hp
      t.string :hp_formula
      t.string :speed
      t.integer :strength
      t.integer :dexterity
      t.integer :constitution
      t.integer :intelligence
      t.integer :wisdom
      t.integer :charisma
      t.string :saving_throws
      t.string :skills
      t.string :damage_resistances
      t.string :damage_immunities
      t.string :condition_immunities
      t.string :senses
      t.string :languages
      t.string :challenge
      t.string :traits
      t.string :actions
      t.string :legendary_actions

      t.timestamps
    end
  end
end
