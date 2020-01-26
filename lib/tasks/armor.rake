namespace :armor do
  desc "Import armor from source json"
  task create: :environment do
    load "lib/tasks/import/armor.rb"
  end
end
