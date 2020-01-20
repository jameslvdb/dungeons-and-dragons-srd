class Spell < ApplicationRecord
  validates :name, presence: true
  validates :level, presence: true
  validates :school, presence: true
  validates :casting_time, presence: true
  validates :range, presence: true
  validates :duration, presence: true
  validates :description, presence: true

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
end
