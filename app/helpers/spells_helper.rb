module SpellsHelper
  def components(spell)
    result = []
    result.append('V') if spell.verbal
    result.append('S') if spell.somatic
    result.append("M (#{spell.material})") if spell.material
    result.join(', ')
  end

  def ordinalize_level(level)
    return 'cantrip' if level == 0
    level.ordinalize
  end

  def show_spell_level(spell)
    result = ""
    if spell.level == 0
      result = "#{spell.school} cantrip"
    else
      result = "#{ordinalize_level(spell.level)}-level #{spell.school.downcase}"
    end
  end
end
