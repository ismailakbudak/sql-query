
# Gem file
# gem 'faker', '1.1.2'

# Taskı çalıştırmak için
# rake db:reset
# rake db:populate

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    #create_team
    create_match
  end
end

def create_team
  10.times do |n|
    team_name  = Faker::Name.name 
    Team.create!(team_name: team_name)
  end
end

def create_match

  2.times do |n|
    Match.create!(  home_id: n + 1,
                    guest_id: n + 2  )
  end
  
end
 