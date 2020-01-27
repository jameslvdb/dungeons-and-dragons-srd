namespace :monsters do
  desc "Import monsters from source json"
  task create: :environment do
    load "lib/tasks/import/monsters.rb"
  end
end
