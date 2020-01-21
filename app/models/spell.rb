class Spell < ApplicationRecord
  SPELL_SCHOOLS = {
    'A' => 'Abjuration',
    'C' => 'Conjuration',
    'D' => 'Divination',
    'E' => 'Enchantment',
    'V' => 'Evocation',
    'I' => 'Illusion',
    'N' => 'Necromancy',
    'T' => 'Transmutation'
  }

  validates :name, presence: true
  validates :level, presence: true, inclusion: { in: 0..9, message: "must be between 0 and 9" }
  validates :school, presence: true, inclusion: { in: SPELL_SCHOOLS.values }
  validates :casting_time, presence: true
  validates :range, presence: true
  validates :duration, presence: true
  validates :description, presence: true
  validates :name, uniqueness: true
end
