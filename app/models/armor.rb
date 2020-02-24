class Armor < ApplicationRecord
  ARMOR_TYPES = {
    'LA' => 'light',
    'MA' => 'medium',
    'HA' => 'heavy',
    'S' => 'shield'
  }

  validates :name, :armor_type, :ac, :strength_requirement, :weight, :value, :description, presence: true
  validates :stealth_disadvantage, inclusion: { in: [ true, false ] }
  validates :value, :weight, :ac, numericality: { greater_than_or_equal_to: 0 }
  validates :strength_requirement, inclusion: { in: 0..20, message: "must be between 0 and 20"}
  validates :name, uniqueness: true
  validates :armor_type, inclusion: { in: ARMOR_TYPES.values }
end
