namespace :conditions do
  desc "Import conditions from source json"
  task create: :environment do
    load "lib/tasks/import/conditions.rb"
  end
end
