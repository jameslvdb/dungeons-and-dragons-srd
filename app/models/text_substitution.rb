module TextSubstitution

  def self.format(doc)
    # format damage and dice notations
    doc.gsub!(/{@(damage|dice) (\d{1,2}d\d{1,3}( *[\+\-] *)?\w*)}/) do
  	  "#{$2}"
    end

    # remove {@h}
    doc.gsub!(/{@h}/, "")

    # format to-hit bonus
    doc.gsub!(/{@hit (\d{1,})}/) do
      "+#{$1}"
    end

    # format DC declarations
    doc.gsub!(/{@dc (\d{1,2})}/) do
      "DC #{$1}"
    end

    # format attack type descriptions
    doc.gsub!(/{@atk (\w+,?\w*)}/) do
      if $1 == 'mw'
        '<em>Melee Weapon Attack:</em>'
      elsif $1 == 'rw'
        '<em>Ranged Weapon Attack:</em>'
      elsif $1 == 'mw,rw'
        '<em>Melee or Ranged Weapon Attack:</em>'
      end
    end

    # format ability recharge notation
    doc.gsub!(/{@recharge (\d)}/) do
      "(Recharge #{$1}-6)"
    end

    doc.gsub!(/{@recharge}/) do
      "(Recharge 6)"
    end

    doc
  end

  def links(str)
    # use working creature links
    str.gsub!(/{@creature (\w+\s?\w*)}/) do
      crt = Creature.find_by(name: $1.downcase)
      link_to crt.name.downcase, creature_path(crt)
    end

    str.gsub!(/{@spell (\w+\s?\w*)}/) do
      spell = Spell.find_by(name: $1.downcase)
      link_to spell.name.downcase, spell_path(spell)
    end

    str.gsub!(/{@condition (\w+)}/) do
      condition = Condition.find_by(name: $1.downcase)
      link_to condition.name.downcase, condition_path(condition)
    end
    str
  end

  def self.format_tables(entry)
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

  def self.format_entry(entry)
    description = ''
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
        description += TextSubstitution.format_tables(entry)
      end
    end
    description
  end
end
