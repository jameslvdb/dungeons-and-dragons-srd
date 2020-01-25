module WeaponsHelper
  def render_damage(weapon)
    result = ''
    result += "#{weapon.damage} #{weapon.damage_type&.downcase}"
    result
  end

  def render_properties(weapon)
    properties = weapon.weapon_properties.pluck(:name)
    return if properties.empty?
    properties.each do |property|
      if property == 'versatile'
        puts 'versatile weapon'
        property << " (#{weapon.two_handed_damage})"
        puts property
      elsif property == 'thrown' || property == 'ammunition'
        property << " (range #{weapon.range})"
      end
    end
    properties.first.capitalize!
    properties.join(', ')
  end
end
