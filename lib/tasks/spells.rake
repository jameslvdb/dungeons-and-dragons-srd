namespace :spells do
  desc "Import spells from source json"
  task create: :environment do
    load "lib/tasks/import/spells.rb"
  end
end
