class CreateSpells < ActiveRecord::Migration[6.0]
  def change
    create_table :spells do |t|
      t.string :name
      t.integer :level
      t.string :school
      t.string :casting_time
      t.string :range
      t.boolean :verbal
      t.boolean :somatic
      t.string :material
      t.string :duration
      t.string :description
      t.string :source
      t.string :classes
      t.boolean :ritual

      t.timestamps
    end
  end
end
