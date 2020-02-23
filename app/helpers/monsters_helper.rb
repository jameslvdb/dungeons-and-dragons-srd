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

  def render_armor(ac)
    if ac.include?('@item')
      ac.gsub!(/{@item (.*?)\|phb}/) do
        armor = Armor.find_by(name: $1.titleize)
        link_to armor.name.downcase, armor_path(armor)
      end
    end
    sanitize ac, scrubber: PermitTableScrubber.new
  end
end
