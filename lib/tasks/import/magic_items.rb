require 'json'

item_file = 'public/data/items.json'

doc = File.open(item_file)
formatted = TextSubstitution.format(doc.read)
parsed = JSON.parse(formatted)
items = parsed['item']

def wondrous?(item)
  item['wondrous'] ? true : false
end

def attunement(item)
  return "true" if item['reqAttune'] == true
  return item['reqAttune']
end

def format_description(item)
  description = ''
  if item['entries'].length > 1
    item['entries'].each do |entry|
      description += TextSubstitution.format_entry(entry)
    end
  else
    description += item['entries'].first
  end
  description
end

items.each do |i|
  next if i['rarity'] == 'None'
  item = MagicItem.find_or_initialize_by(name: i['name'].downcase)
  item.wondrous = wondrous?(i)
  item.weight = i['weight']
  item.tier = i['tier']
  item.rarity = i['rarity']
  item.attunement = attunement(i)
  item.description = format_description(i) unless i['entries'].nil?
  item.save!
end
