## sql-query
Advanced relational model and sql-query example with Ruby on Rails

We want to get a list of the team that scores higher in the first half than the second half.

## Models 

+ Team
  - id
  - name
+ Player
  - id
  - team_id
  - player_number
  - player_name
+ Match
  - id
  - home_id
  - guest_id
  - match_date     
+ Goal
  - id
  - match_id
  - player_id
  - minute 

## Example 
+ The count of total scores of team that scored first half
```ruby
    # SELECT COUNT(*) FROM "goals" 
    # INNER JOIN "players" ON "players"."id" = "goals"."player_id" 
    # INNER JOIN "matches" ON "matches"."id" = "goals"."match_id" 
    # WHERE (matches.home_id = 1 OR matches.guest_id = 1) 
    #        AND "players"."team_id" = 1 
    #        AND (goals.minute <= '45')
    def first_half
    	team = self
    	Goal.joins(:player).joins(:match)
            .where("matches.home_id = :id OR matches.guest_id = :id", :id => team.id)
            .where( { players: { team_id: team.id } } )
            .where("goals.minute <= ?", "45").count
    end
```

+ This sql sccript gives you the team list that score higher in the first half than the second half.
```sql
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
        and g.minute > 45  
 )
```
## Usage
Set your database
- `config/database.yml` 

Run command
* `rake db:migrate`

Open browser
* `rails s`
* `localhost:3000`

I am using faker gem for some data 
* `gem 'faker', '1.1.2'`

Also look : 
* `lib/tasks/data.rake` 

If you want to fill your database with simple data you can run this commands
- `rake db:reset`    
- `rake db:populate` 
 
