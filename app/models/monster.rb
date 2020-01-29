class Monster < ApplicationRecord
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
