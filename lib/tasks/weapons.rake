namespace :weapons do
  desc "Import weapons from source json"
  task create: :environment do
    load "lib/tasks/import/weapons.rb"
  end
end
