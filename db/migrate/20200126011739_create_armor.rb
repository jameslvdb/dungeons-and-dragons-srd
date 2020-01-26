class CreateArmor < ActiveRecord::Migration[6.0]
  def change
    create_table :armor do |t|
      t.string :name
      t.string :armor_type
      t.integer :ac
      t.integer :strength_requirement
      t.boolean :stealth_disadvantage
      t.integer :weight
      t.integer :value
      t.string :description

      t.timestamps
    end
  end
end
