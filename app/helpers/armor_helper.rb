module ArmorHelper
  def render_armor_class(armor)
    if armor.armor_type == 'light'
      return "#{armor.ac} + Dex modifier"
    elsif armor.armor_type == 'medium'
      return "#{armor.ac} + Dex modifier (max 2)"
    end
    armor.ac
  end
end
