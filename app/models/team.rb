class Team < ActiveRecord::Base
	has_many :players 

    # This codes gives you guest teams
    has_many :matches, foreign_key: "guest_id", dependent: :destroy 
    has_many :homes, through: :matches, source: :home

    # This codes gives you home teams
    has_many :reverse_matches, foreign_key: "home_id", class_name:  "Match", dependent:   :destroy
    has_many :guests, through: :reverse_matches, source: :guest

end
