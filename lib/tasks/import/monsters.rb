require 'json'

monster_file = 'public/data/monsters.json'

doc = File.open(monster_file)
formatted = TextSubstitution.format(doc.read)
parsed = JSON.parse(formatted)
monsters = parsed['monster']

def set_alignment(monster, m)
  non_good_names = ['assassin', 'cultist', 'cult fanatic', 'thug']
  non_lawful_names = ['bandit', 'bandit captain']
  if non_good_names.include? monster.name
    monster.alignment = 'any non-good alignment'
  elsif non_lawful_names.include? monster.name
    monster.alignment = 'any non-lawful alignment'
  elsif monster.name == 'berserker'
    monster.alignment = 'any chaotic alignment'
  elsif monster.name == 'cloud giant'
    monster.alignment = 'neutral good (50%) or neutral evil (50%)'
  elsif monster.name == 'lich'
    monster.alignment = 'any evil alignment'
  else
    monster.alignment = Alignment::ALIGNMENTS[m['alignment'].join]
  end
  monster
end

def set_armor_class(monster, m)
  monster.ac = m['ac'].first if m['ac'].first.class == Integer
  if m['ac'].first.class == Hash
    if m['ac'].first['from']
      monster.ac = "#{m['ac'].first['ac']} (#{m['ac'].first['from'].first})"
    end
    if monster.name == 'werebear'
      monster.ac = '10 in humanoid form, 11 (natural armor) in bear and hybrid form'
    elsif monster.name == 'wereboar'
      monster.ac = '10 in humanoid form, 11 (natural armor) in boar or hybrid form'
    elsif monster.name == 'werewolf'
      monster.ac = '11 in humanoid form, 12 (natural armor) in wolf or hybrid form'
    end
  end
  if monster.name == 'ankheg'
    monster.ac = '14 (natural armor), 11 while prone'
  elsif monster.name == 'archmage' || monster.name == 'mage'
    monster.ac = '12 (15 with <em>mage armor</em>)'
  elsif monster.name == 'druid' || monster.name == 'dryad'
    monster.ac = '11 (16 with <em>barkskin</em>)'
  end
  monster
end

def set_speed(monster, m)
  speed = m['speed']
  if speed.length == 1
    if speed.keys.first == 'walk'
      monster.speed = "#{speed['walk']} ft."
    elsif speed.keys.first == 'swim'
      monster.speed = "0 ft., swim #{speed['swim']} ft."
    end

    if monster.name == 'werebear'
      monster.speed = '30 ft. (40 ft., climb 30 ft. in bear or hybrid form)'
    elsif monster.name == 'wereboar'
      monster.speed = '30 ft. (40 ft. in boar form)'
    elsif monster.name == 'weretiger'
      monster.speed = '30 ft. (40 ft. in tiger form)'
    elsif monster.name == 'werewolf'
      monster.speed = '30 ft. (40 ft. in wolf form)'
    end

    return monster
  end

  if speed.all? {|k, v| v.is_a? Integer}
    result = "#{speed['walk']} ft., "
    speed.each do |key, value|
      next if key == 'walk'
      result << "#{key} #{value} ft., "
    end
    monster.speed = result.delete_suffix(', ')
  else
    result = ""
    result = "#{speed['walk'] || 0} ft., "
    result << "fly #{speed['fly']['number']} ft. (hover)"
    monster.speed = result
  end

  monster
end

def set_hash_fields(hash)
  return nil if hash.nil?
  result = ""
  hash.each do |key, value|
    result << "#{key.capitalize} #{value}, "
  end
  result.delete_suffix(', ')
end

def set_damage_defenses(defenses)
  return nil if defenses.nil?
  return defenses.to_sentence if defenses.all? {|elem| elem.is_a? String}

  result = ""
  strings = []
  specials = ''
  defenses.each do |elem|
    strings << elem if elem.is_a? String
    specials = elem if elem.is_a? Hash
  end
  result << strings.to_sentence + '; ' if !strings.empty?
  result << "#{specials['immune'].to_sentence} #{specials['note']}" if specials['immune']
  result << "#{specials['resist'].to_sentence} #{specials['note']}" if specials['resist']
  result
end

def format_action_entries(entries)
  result = ""
  entries&.each do |entry|
    if entry.is_a? Hash
      if entry['type'] == 'list'
        entry['items'].each do |item|
          result << "<b><em>#{item['name']}</em></b> #{item['entry']}<br>"
        end
      end
    else
      result << "#{entry}<br>"
    end
  end
  result
end

# Formats actions as well
def format_traits(traits)
  result = ""
  traits&.each do |trait|
    result << "<b><em>#{trait['name']}.</em></b> #{format_action_entries(trait['entries'])}<br>"
  end
  result.delete_suffix('<br>')
end

def format_spellcasting(spells, name)
  result = ""
  result << "<b><em>#{spells['name']}.</em></b> #{spells['headerEntries'].first}<br>"
  spells['spells']&.each do |level, s|
    result << 'Cantrips (at will): ' if level.to_i == 0
    result << "#{level.to_i.ordinalize} level (#{s['slots']} slots): " if level.to_i > 0
    result << "#{s['spells'].join(', ')}<br>"
  end

  result << "At will: #{spells['will'].join(', ')}<br>" if spells['will']
  if spells['daily']
    daily_spells = spells['daily']
    result << "3/day each: #{daily_spells['3e'].join(', ')}<br>" if daily_spells['3e']
    result << "2/day each: #{daily_spells['2e'].join(', ')}<br>" if daily_spells['2e']
    result << "1/day each: #{daily_spells['1e'].join(', ')}<br>" if daily_spells['1e']
  end
  result.delete_suffix('<br>')
end

monsters.each do |m|
  # puts m['name'] if m['_copy']
  next if m['_copy']

  monster = Monster.find_or_initialize_by(name: m['name'].downcase)
  monster.size = Size::SIZES[m['size']]
  # some monsters have hashes for monster type
  m['type'].class == String ? monster.monster_type = m['type'] : monster.monster_type = m['type']['type']

  monster = set_alignment(monster, m)
  monster = set_armor_class(monster, m)

  monster.hp = m['hp']['average'] || m['hp']['special']
  monster.hp_formula = m['hp']['formula'] || m['hp']['special']

  monster = set_speed(monster, m)

  monster.saving_throws = set_hash_fields(m['save'])
  monster.skills = set_hash_fields(m['skill'])
  monster.damage_immunities = set_damage_defenses(m['immune'])
  monster.condition_immunities = m['conditionImmune']&.join(', ')
  monster.damage_resistances = m['resist']
  monster.damage_resistances = set_damage_defenses(m['resist'])

  # attribute scores
  monster.strength = m['str']
  monster.dexterity = m['dex']
  monster.constitution = m['con']
  monster.intelligence = m['int']
  monster.wisdom = m['wis']
  monster.charisma = m['cha']

  monster.senses = "#{m['senses']&.join(', ')}"
  monster.senses << ", " if m['senses']
  monster.senses << "passive Perception #{m['passive']}"

  monster.languages = m['languages']&.join(', ')

  # puts m['cr']
  if m['cr'].is_a?(Hash)
    monster.challenge = m['cr']['cr']
  elsif m['cr'].is_a?(String)
    if m['cr'] == 'Unknown'
      monster.challenge == nil
    else
      monster.challenge = m['cr']
    end
  end
  monster.traits = format_traits(m['trait'])
  monster.spellcasting = m['spellcasting']
  monster.spellcasting = format_spellcasting(m['spellcasting'].first, monster.name) unless m['spellcasting'].nil?
  monster.actions = format_traits(m['action'])
  monster.legendary_actions = format_traits(m['legendary'])

  monster.save!
end
