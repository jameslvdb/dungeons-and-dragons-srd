json.extract! spell, :id, :name, :level, :school, :casting_time, :range, :verbal, :somatic, :material, :duration, :description, :source, :classes, :ritual, :created_at, :updated_at
json.url spell_url(spell, format: :json)
