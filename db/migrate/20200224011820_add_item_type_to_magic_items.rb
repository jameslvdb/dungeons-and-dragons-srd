class AddItemTypeToMagicItems < ActiveRecord::Migration[6.0]
  def change
    add_column :magic_items, :item_type, :string
  end
end
