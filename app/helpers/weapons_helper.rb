module WeaponsHelper
  def render_damage(weapon)
    result = ''
    result += "#{weapon.damage} #{weapon.damage_type&.downcase}"
    result += " (#{weapon.two_handed_damage})" if weapon.two_handed_damage
    result
  end
end
