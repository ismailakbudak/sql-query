class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      
      t.references :team, index: true
      t.string     :player_name
      t.integer    :number
      
      t.timestamps
    end 
 
  end
end
