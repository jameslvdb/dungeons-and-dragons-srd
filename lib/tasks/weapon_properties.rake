namespace :weapon_properties do
  desc "Import weapon properties from source json"
  task create: :environment do
    load "lib/tasks/import/weapon_properties.rb"
  end
end
