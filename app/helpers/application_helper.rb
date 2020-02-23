module ApplicationHelper
  def substitute_links(str)
    # use working creature links
    # str.gsub!(/{@creature (\w+\s?\w*)}/) do
    #   crt = Creature.find_by(name: $1.downcase)
    #   link_to crt.name.downcase, creature_path(crt)
    # end

    str.gsub!(/{@spell (.*?)}/) do
      spell = Spell.find_by(name: $1.downcase)
      link_to spell.name.downcase, spell_path(spell)
    end

    str.gsub!(/{@condition (\w+)}/) do
      condition = Condition.find_by(name: $1.downcase)
      link_to condition.name.downcase, condition_path(condition)
    end
    str
  end

  def format_value(value)
    if value % 100 == 0
      return "#{value / 100} gp"
    elsif value % 10 == 0
      return "#{value / 10} sp"
    end
    "#{value} cp"
  end
end
