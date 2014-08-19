class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      
      t.references :match,  index: true
      t.references :player, index: true
      t.integer    :minute

      t.timestamps
    end
  end
end
