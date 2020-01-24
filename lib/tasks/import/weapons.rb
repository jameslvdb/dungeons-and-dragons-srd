require 'json'

def format_description(w, name)
  description = ''
  entries = w['entries'].first['entries']
  if entries.length == 1
    description += TextSubstitution.format_entry(entries.first)
  else
    w['entries'].each do |entry|
      description += TextSubstitution.format_entry(entry)
    end
  end
  description
end

file = 'public/data/weapons.json'
doc = File.open(file)
formatted = TextSubstitution.format(doc.read)
parsed = JSON.parse(formatted)
weapons = parsed['weapons']

weapon_types = {
  'M' => 'melee',
  'R' => 'ranged'
}

# split the string and multiply str[0] by cp (1), sp (10), gp (100)
def format_value(value)
  str = value.split
  if str[1] == 'gp'
    return str[0].to_i * 100
  elsif str[1] == 'sp'
    return str[0].to_i * 10
  elsif str[1] == 'cp'
    return str[0].to_i
  end
  str[0].to_i
end

def create_weapon_property_associations(weapon, w)
  if w['property']
    w['property'].each do |property|
      # 'S' is a special case, don't create an association
      if property == 'S'
        weapon.description = w['entries'].first['entries'].first
        next
      end
      if weapon.weapon_properties.where(abbreviation: property).exists?
        weapon.weapon_properties << WeaponProperty.find_by(abbreviation: property)
      end
    end
  end
  # return the Weapon object at the end
  weapon
end

def create_dart(w)
  weapon = Weapon.find_or_initialize_by(name: 'darts (4)')
  weapon.weapon_type = 'ranged'
  weapon.damage_type = Damage::DAMAGE_TYPES[w['dmgType']]
  weapon.damage = w['dmg1']
  weapon.category = w['weaponCategory'].downcase
  weapon.value = 20
  weapon.weight = 1
  weapon.range = w['range']
  weapon = create_weapon_property_associations(weapon, w)
  weapon.save!
end

weapons.each do |w|
  # do something different for the 'Dart' entry
  if w['name'] == 'Dart'
    create_dart(w)
    next
  end
  weapon = Weapon.find_or_initialize_by(name: w['name'].downcase)
  weapon.weapon_type = weapon_types[w['type']]
  weapon.damage_type = Damage::DAMAGE_TYPES[w['dmgType']]
  weapon.damage = w['dmg1']
  weapon.two_handed_damage = w['dmg2']
  weapon.category = w['weaponCategory'].downcase
  weapon.value = format_value(w['value'])
  weapon.weight = w['weight'] || 0
  weapon.range = w['range']
  weapon = create_weapon_property_associations(weapon, w)
  weapon.save!
end
