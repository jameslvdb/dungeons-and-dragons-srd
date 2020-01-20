module SpellsHelper
  def components(spell)
    result = []
    result.append('V') if spell.verbal
    result.append('S') if spell.somatic
    if !spell.material.nil?
      if spell.material[0] == '{'
        result.append("M (#{eval(spell.material)['text']})")
      elsif spell.material
        result.append("M (#{spell.material})")
      end
    end
    result.join(', ')
  end
end
