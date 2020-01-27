require 'json'

monster_file = 'public/data/monsters.json'

doc = File.open(monster_file)
formatted = TextSubstitution.format(doc.read)
parsed = JSON.parse(formatted)
monsters = parsed['monster']

monsters.each do |m|
  # puts m['name'] if m['_copy']
  next if m['_copy']

  monster = Monster.find_or_initialize_by(name: m['name'].downcase)
  monster.size = Size::SIZES[m['size']]
  puts monster.size
  # some monsters have hashes for monster type
  m['type'].class == String ? monster.monster_type = m['type'] : monster.monster_type = m['type']['type']
  monster.alignment = Alignment::ALIGNMENTS[m['alignment'].join]
  m['ac'].first.class == Integer ? monster.ac = m['ac'].first : monster.ac = m['ac'].first['ac']
  # TODO: fix these monsters
  puts "#{m['ac'].length}: #{monster.name}" if m['ac'].length != 1
  monster.hp = m['hp']['average'] || m['hp']['special'].split.first
  monster.hp_formula = m['hp']['formula'] || m['hp']['special'].split[1..-1].join(' ')
  monster.speed = m['speed']
  monster.saving_throws = m['save']
  monster.skills = m['skill']
  monster.damage_immunities = m['immune']
  monster.condition_immunities = m['conditionImmune']
  monster.damage_resistances = m['resist']

  # attribute scores
  monster.strength = m['str']
  monster.dexterity = m['dex']
  monster.constitution = m['con']
  monster.intelligence = m['int']
  monster.wisdom = m['wis']
  monster.charisma = m['cha']

  monster.senses = m['senses']
  # add languages to table
  monster.languages = m['languages']
  if m['cr'].is_a?(Hash)
    monster.challenge = m['cr']['cr']
  elsif m['cr'].is_a?(String)
    if m['cr'] == 'Unknown'
      monster.challenge == nil
    else
      monster.challenge = m['cr'].to_i
    end
  end
  monster.traits = m['trait']
  monster.spellcasting = m['spellcasting']
  # if m['spellcasting']
  #   puts "#{m['spellcasting'].length}: #{monster.name}" if m['spellcasting'].length > 1
  # end
  monster.actions = m['action']
  monster.legendary_actions = m['legendary']

  # puts monster.inspect
  # monster.save!
end
