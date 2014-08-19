class Team < ActiveRecord::Base
	has_many :players 

    # This codes gives you guest teams
    has_many :matches, foreign_key: "guest_id", dependent: :destroy 
    has_many :homes, through: :matches, source: :home

    # This codes gives you home teams
    has_many :reverse_matches, foreign_key: "home_id", class_name:  "Match", dependent:   :destroy
    has_many :guests, through: :reverse_matches, source: :guest
    
=begin
İlk yarıda attığı gol sayısı ikinci yarıda attığı gol sayısından büyük olan takımların listesi
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
    def get_first
    	
    end

end
