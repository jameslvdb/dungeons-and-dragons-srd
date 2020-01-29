module MonstersHelper
  def render_size_type_alignment(monster)
    "#{monster.size} #{monster.monster_type}, #{monster.alignment}"
  end

  def render_hp(monster)
    "#{monster.hp} (#{monster.hp_formula})"
  end

  def ability(score)
    "#{score} (#{score > 9 ? '+' : ''}#{(score - 10) / 2})"
  end
end
