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

  validates :name, :level, :school, :casting_time, :range, :duration, :description, presence: true
  validates :level, inclusion: { in: 0..9, message: "must be between 0 and 9" }
  validates :school, inclusion: { in: SPELL_SCHOOLS.values }
  validates :name, uniqueness: true
end
