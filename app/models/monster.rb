class Monster < ApplicationRecord
  validates :name, :size, :monster_type, :hp, :hp_formula, :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma, :senses, :challenge, presence: true
  # validates :size, inclusion: { in: Size::SIZES.values }

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
