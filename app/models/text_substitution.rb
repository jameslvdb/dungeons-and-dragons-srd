module TextSubstitution

  def self.format(doc)
    # format damage and dice notations
    doc.gsub!(/{@(damage|dice) (\d{1,2}d\d{1,3}( *\+ *)?\w*)}/) do
  	  "#{$2}"
    end

    # remove {@h}
    doc.gsub!(/{@h}/, "")

    # format to-hit bonus
    doc.gsub!(/{@hit (\d{1,})}/) do
      "+#{$1}"
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

    doc
  end

  def self.links(str)
    # use working creature links
    str.gsub!(/{@creature (\w+\s?\w*)}/) do
      crt = Creature.find_by(name: $1.downcase)
      link_to crt.name.downcase, creature_path(crt)
    end

    str.gsub!(/{@spell (\w+\s?\w*)}/) do
      spell = Spell.find_by(name: $1.downcase)
      link_to spell.name.downcase, spell_path(spell)
    end
    str
  end
end
