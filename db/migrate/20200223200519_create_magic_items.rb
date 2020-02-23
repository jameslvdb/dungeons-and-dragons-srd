class CreateMagicItems < ActiveRecord::Migration[6.0]
  def change
    create_table :magic_items do |t|
      t.string :name
      t.boolean :wondrous
      t.float :weight
      t.string :tier
      t.string :rarity
      t.string :attunement
      t.string :description

      t.timestamps
    end
  end
end
