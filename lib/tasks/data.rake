
# Gem file
# gem 'faker', '1.1.2'

# Taskı çalıştırmak için
# rake db:reset
# rake db:populate

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    #create_team
    #create_match
    #create_player
    create_goal
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
 
def create_player
  3.times do |n|
    player_name  = Faker::Name.name 
    Player.create!( player_name: player_name,
                    team_id:     1)
    player_name  = Faker::Name.name 
    Player.create!( player_name: player_name,
                    team_id:     2)
  end
end

def create_goal
    m1 = Match.first 
    p1 = m1.home.players.first
    3.times do |n|
        Goal.create!(  match_id:   m1.id,
                       player_id:  p1.id,
                       minute:     (n + 1) * 20  )
    end      
end