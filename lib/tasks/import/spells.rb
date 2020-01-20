require 'json'

spell_file = 'public/data/spells.json'

def format_range(range)
  range_type = range['type']
  # Special range
  return range_type unless range['distance']

  amount = range['distance']['amount']
  distance_unit = range['distance']['type']

  if range_type == 'radius' # Radius with Self at origin
    return 'Self (' + amount.to_s + '-' + distance_unit.singularize + ' radius)'
  end

  if amount # if range has some numerical unit associated with it
    return amount.to_s + ' ' + distance_unit
  else
    return distance_unit.capitalize
  end
end

def format_duration(duration)
  d = duration.first
  concentration = d['concentration']
  type = d['type']
  return 'Instantaneous' if type == 'instant'
  return 'Until dispelled' if type == 'permanent'
  return 'Special' if type == 'special'

  time_unit = d['duration']['type']
  amount = d['duration']['amount']
  amount > 1 ? time_unit = time_unit.pluralize : time_unit
  if concentration
    return 'Concentration, up to ' + amount.to_s + ' ' + time_unit
  else
    return amount.to_s + ' ' + time_unit
  end
end

def format_tables(entry)
  tables = ''
  tables += "<h3>#{entry['caption']}</h3>"
  tables += '<table><tr>'
  entry['colLabels'].each do |header|
    tables += "<th>#{header}</th>"
  end
  tables += '</tr>'
  entry['rows'].each do |row|
    tables += '<tr>'
    row.each do |cell|
      tables += "<td>#{cell}</td>"
    end
    tables += '</tr>'
  end
  tables += '</table>'
  tables
end

def format_description(s, name)
  description = ''
  if s['entries'].length > 1
    s['entries'].each do |entry|
      if entry.is_a?(String) # just append the string
        description += (entry + '<br>')
      elsif entry.is_a?(Hash)
        # we have three types here: 'entries', 'table', 'list'
        # process subentries
        if entry['type'] == 'entries'
          description += "<br><strong><em>#{entry['name']}. </em></strong>"
          # Add a br after each subentry unless it's the last one
          entry['entries'].each do |subentry|
            description += subentry.to_s
            description += '<br>' unless subentry == entry['entries'].last
          end
        # process lists
        elsif entry['type'] == 'list'
          description += '<ul>'
          entry['items'].each do |item|
            description += "<li>#{item}</li>"
          end
          description += '</ul>'
        # process tables
        elsif entry['type'] == 'table'
          description += format_tables(entry)
        end
      end
    end
  else
    description += s['entries'].first
  end
  if s['entriesHigherLevel']
    higher_levels = s['entriesHigherLevel']
    description += "<br><strong><em>At Higher Levels.</em></strong> #{higher_levels.first['entries'].first}"
  end
  description
end

def get_classes(classes)
  result = []
  classes['fromClassList'].each do |klass|
    result << klass['name'] if klass['source'] == "PHB"
  end
  result.join(", ")
end

doc = File.open(spell_file)
formatted = TextSubstitution.format(doc.read)
parsed = JSON.parse(formatted)
spells = parsed['spell']

spells.each do |s|
  spell = Spell.find_or_initialize_by(name: s['name'].downcase)
  spell.level = s['level']
  spell.school = Spell::SPELL_SCHOOLS[s['school']]

  time = s['time'].first
  time['number'] > 1 ? time_unit = time['unit'].pluralize : time_unit = time['unit']
  spell.casting_time = time['number'].to_s + ' ' + time_unit

  spell.range = format_range(s['range'])
  spell.duration = format_duration(s['duration'])

  spell.verbal = s['components']['v']
  spell.somatic = s['components']['s']
  spell.material = s['components']['m']
  # spell.source = Source::SOURCES[s['source']] + ', ' + s['page'].to_s
  spell.source = "Player's Handbook"
  ritual = s['meta']['ritual'] if s['meta']
  spell.ritual = ritual
  spell.description = format_description(s, spell.name)
  spell.classes = get_classes(s['classes'])
  spell.save!
end
