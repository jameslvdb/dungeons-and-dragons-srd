class WeaponProperty < ApplicationRecord
  validates :name, :abbreviation, presence: true
  validates :name, :abbreviation, uniqueness: true
end
