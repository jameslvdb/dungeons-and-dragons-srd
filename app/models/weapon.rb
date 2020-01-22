class Weapon < ApplicationRecord
  has_and_belongs_to_many :weapon_properties

  # TODO: refactor validations to work while allowing the exceptions for net and sling
  validates :name, :weapon_type, :category, :value, :weight, presence: true
  validates :value, :weight, numericality: { greater_than_or_equal_to: 0 }
  validates :name, uniqueness: true
end
