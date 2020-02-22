class Monster < ApplicationRecord
  validates :name, :size, :monster_type, :hp, :hp_formula, :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma, :senses, presence: true
  validates :size, inclusion: { in: Size::SIZES.values }
  validates :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma, numericality: { greater_than_or_equal_to: 0 }

  def ability_scores
    return {
      str: strength,
      dex: dexterity,
      con: constitution,
      int: intelligence,
      wis: wisdom,
      cha: charisma
    }
  end
end
