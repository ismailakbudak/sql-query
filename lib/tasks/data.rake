
# Gem file
# gem 'faker', '1.1.2'

# Run this command from console
# rake db:reset
# rake db:populate

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    create_team
    create_match
    create_player
    create_goal
  end
end

# Create 10 teams 
def create_team
  10.times do |n|
    team_name  = Faker::Name.name 
    Team.create!(team_name: team_name)
  end
end

# Create 1 matches
# Home team_id => 1 
# Guest team_id => 1
def create_match
    Match.create!(  home_id: 1, guest_id: 2  )
end

# Create 6 player 
# 3 of them are from team_id => 1
# 3 of them are from team_id => 2
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

# Create 6 goals
# 3 of them are from player_id => 1. It belongs to team_id => 1 
# 3 of them are from player_id => 1. It belongs to team_id => 2
def create_goal
    m1 = Match.first 
    p1 = m1.home.players.first
    3.times do |n|
        Goal.create!(  match_id:   m1.id,
                       player_id:  p1.id,
                       minute:     (n + 1) * 20  )
    end    

    m1 = Match.first 
    p1 = m1.guest.players.first
    3.times do |n|
        Goal.create!(  match_id:   m1.id,
                       player_id:  p1.id,
                       minute:     (n + 1) * 30  )
    end      
end