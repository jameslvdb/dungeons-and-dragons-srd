class WeaponProperty < ApplicationRecord
  has_and_belongs_to_many :weapons
  
  validates :name, :abbreviation, presence: true
  validates :name, :abbreviation, uniqueness: true
end
