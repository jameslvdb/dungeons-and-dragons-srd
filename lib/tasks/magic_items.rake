namespace :magic_items do
  desc "Import magic items from source json"
  task create: :environment do
    load "lib/tasks/import/magic_items.rb"
  end
end
