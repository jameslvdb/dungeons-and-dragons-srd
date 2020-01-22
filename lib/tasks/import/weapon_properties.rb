require 'json'

def format_description(p, name)
  description = ''
  entries = p['entries'].first['entries']
  if entries.length == 1
    description += TextSubstitution.format_entry(entries.first)
  else
    p['entries'].each do |entry|
      description += TextSubstitution.format_entry(entry)
    end
  end
  description
end

file = 'public/data/weapon_properties.json'
doc = File.open(file)
formatted = TextSubstitution.format(doc.read)
parsed = JSON.parse(formatted)
properties = parsed['itemProperty']

properties.each do |p|
  next if p['abbreviation'] == 'S'
  next if p['source'] != 'PHB'
  property = WeaponProperty.find_or_initialize_by(name: p['entries'].first['name'].downcase)
  property.abbreviation = p['abbreviation']
  property.description = format_description(p, property.name)
  property.save!
end
