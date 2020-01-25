module WeaponsHelper
  def render_damage(weapon)
    result = ''
    result += "#{weapon.damage} #{weapon.damage_type&.downcase}"
    result
  end

  def render_properties(weapon)
    properties = weapon.weapon_properties.pluck(:name)
    # get out early if no properties exist
    return if properties.empty?
    properties.each do |property|
      # show two-handed damage in the properties column
      if property == 'versatile'
        property << " (#{weapon.two_handed_damage})"
      # show range in the properties column
      elsif property == 'thrown' || property == 'ammunition'
        property << " (range #{weapon.range})"
      end
    end
    properties.first.capitalize!
    properties.join(', ')
  end
end
