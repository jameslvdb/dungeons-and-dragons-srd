class MagicItem < ApplicationRecord
  scope :armor, -> { where("item_type ~ '^Armor'") }
end
