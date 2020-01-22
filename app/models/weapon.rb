class Weapon < ApplicationRecord
  has_and_belongs_to_many :weapon_properties

  validates :name, :weapon_type, :damage_type, :damage, :category, :value, :weight, presence: true
  validates :value, :weight, numericality: { greater_than: 0 }
end
