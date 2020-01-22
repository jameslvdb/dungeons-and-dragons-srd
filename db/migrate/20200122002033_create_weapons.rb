class CreateWeapons < ActiveRecord::Migration[6.0]
  def change
    create_table :weapons do |t|
      t.string :name
      t.string :weapon_type
      t.string :damage_type
      t.string :damage
      t.string :two_handed_damage
      t.string :category
      t.integer :value
      t.integer :weight
      t.string :range
      t.string :description

      t.timestamps
    end
  end
end
