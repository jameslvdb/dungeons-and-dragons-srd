module ApplicationHelper
  def substitute_links(str)
    # use working creature links
    str.gsub!(/{@creature ([^|}]*?)(?:\|\|([^}]*?))?}/) do
      monster = Monster.find_by(name: $1.downcase)
      if monster.nil?
        $1
      else
        link_to ($2 || monster.name.downcase), monster_path(monster)
      end
    end

    str.gsub!(/{@creature ([^|}]*?)(?:\|([^}]*?))?}/) do
      monster = Monster.find_by(name: $1.downcase)
      link_to monster.name.downcase, monster_path(monster)
    end

    str.gsub!(/{@item ([^|}]*?)(?:\|([^}]*?))?}/) do
      item = MagicItem.find_by(name: $1.downcase)
      if item.nil?
        $1
      else
        link_to item.name.downcase, magic_item_path(item)
      end
    end

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
