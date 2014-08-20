class Team < ActiveRecord::Base
	has_many :players 

    
    # Team.second.matches
    # SELECT "matches".* FROM "matches"  WHERE "matches"."guest_id" = $1  [["guest_id", 2]]
    has_many :matches, foreign_key: "guest_id", dependent: :destroy 

    # This codes gives you guest teams
    # Team.find(5).homes
    # SELECT "teams".* FROM "teams" INNER JOIN "matches" ON "teams"."id" = "matches"."home_id" WHERE "matches"."guest_id" = $1  [["guest_id", 5]]
    has_many :homes, through: :matches, source: :home
    
    
    # Team.second.reverse_matches
    # SELECT "matches".* FROM "matches"  WHERE "matches"."home_id" = $1  [["home_id", 2]]
    has_many :reverse_matches, foreign_key: "home_id", class_name:  "Match", dependent:   :destroy
    
    # This codes gives you home teams
    # Team.find(5).guests
    # SELECT "teams".* FROM "teams" INNER JOIN "matches" ON "teams"."id" = "matches"."guest_id" WHERE "matches"."home_id" = $1  [["home_id", 5]]
    has_many :guests, through: :reverse_matches, source: :guest
    
  
    # SELECT COUNT(*) FROM "players" 
    # INNER JOIN "goals" ON "goals"."player_id" = "players"."id" 
    # INNER JOIN "teams" ON "teams"."id" = "players"."team_id" 
    # WHERE "players"."team_id" = 1
    def goals
    	 Player.joins(:goals).joins(:team).where( team_id: self.id ).count
    end

    # SELECT COUNT(*) FROM "goals" 
    # INNER JOIN "players" ON "players"."id" = "goals"."player_id" 
    # INNER JOIN "matches" ON "matches"."id" = "goals"."match_id" 
    # WHERE (matches.home_id = 1 OR matches.guest_id = 1) AND "players"."team_id" = 1 AND (goals.minute <= '45')
    def first_half
    	team = self
    	Goal.joins(:player).joins(:match)
            .where("matches.home_id = :id OR matches.guest_id = :id", :id => team.id)
            .where( { players: { team_id: team.id } } )
            .where("goals.minute <= ?", "45").count
    end
    
    # SELECT COUNT(*) FROM "goals" 
    # INNER JOIN "players" ON "players"."id" = "goals"."player_id" 
    # INNER JOIN "matches" ON "matches"."id" = "goals"."match_id" 
    # WHERE (matches.home_id = 1 OR matches.guest_id = 1) AND "players"."team_id" = 1 AND (goals.minute >= '45')
    def second_half 
    	team = self
    	Goal.joins(:player).joins(:match)
            .where("matches.home_id = :id OR matches.guest_id = :id", :id => team.id)
            .where( { players: { team_id: team.id } } )
            .where("goals.minute >= ?", "45").count
    end
    
    def is_bigger
    	team = self
    	result =  team.first_half - team.second_half 
    	if result > 0
    	    true
    	else
    		false
    	end
    end


# This sql sccript gives you the team list that score higher in the first half than the second half.
=begin
select * from teams t where 
( 
  select count( distinct g.id) from goals g 
  inner join matches m on m.id  = g.match_id 
  inner join players p on p.team_id = t.id 
  where ( m.home_id = t.id or m.guest_id = t.id ) 
        and g.player_id = p.id
        and g.minute <= 45     
) > ( 
  select count( distinct g.id) from goals g 
  inner join matches m on m.id  = g.match_id 
  inner join players p on p.team_id = t.id 
  where ( m.home_id = t.id or m.guest_id = t.id ) 
        and g.player_id = p.id
        and g.minute >= 45  
 )
=end  

# Example
# Goal.joins(:player).joins(:match)
# SELECT "goals".* FROM "goals" 
# INNER JOIN "players" ON "players"."id" = "goals"."player_id" 
# INNER JOIN "matches" ON "matches"."id" = "goals"."match_id"

# Example
# Match.joins(:goals).where({ matches: { home_id: 2 } })
# SELECT "matches".* FROM "matches" 
# INNER JOIN "goals" ON "goals"."match_id" = "matches"."id" 
# WHERE "matches"."home_id" = 2

     
end


