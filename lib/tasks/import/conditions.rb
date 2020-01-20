require 'json'

def format_description(c, name)
  description = ''
  if c['entries'].length == 1
    c['entries'].first['items'].each do |entry|
      description += TextSubstitution.format_entry(entry)
    end
  else
    c['entries'].each do |entry|
      description += TextSubstitution.format_entry(entry)
    end
  end
  description
end

file = 'public/data/conditions.json'
doc = File.open(file)
formatted = TextSubstitution.format(doc.read)
parsed = JSON.parse(formatted)
conditions = parsed['condition']

conditions.each do |c|
  condition = Condition.find_or_initialize_by(name: c['name'].downcase)
  condition.description = format_description(c, condition.name)
  condition.save!
end
