json.extract! monster, :id, :name, :size, :monster_type, :ac, :hp, :hp_formula, :speed, :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma, :saving_throws, :skills, :damage_resistances, :damage_immunities, :condition_immunities, :senses, :languages, :challenge, :traits, :actions, :legendary_actions, :created_at, :updated_at
json.url monster_url(monster, format: :json)
