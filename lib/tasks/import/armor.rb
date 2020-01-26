require 'json'

doc = File.open('public/data/armor.json')
formatted = TextSubstitution.format(doc.read)
parsed = JSON.parse(formatted)
all_armor = parsed['armor']

all_armor.each do |a|
  armor = Armor.find_or_initialize_by(name: a["name"])
  puts armor.name
  armor.ac = a["ac"]
  armor.armor_type = Armor::ARMOR_TYPES[a["type"]]
  armor.weight = a["weight"].to_i
  # Assign strength_requirement if the field exists
  a["strength"] ? armor.strength_requirement = a["strength"] : armor.strength_requirement = 0
  puts armor.name
  armor.value = a["value"].split[0].to_i * 100
  armor.description = a["entries"].first if a["entries"].first.class == String
  # Set stealth_disadvantage to true if it exists
  a["stealth"] ? armor.stealth_disadvantage = true : armor.stealth_disadvantage = false
  armor.save!
end
