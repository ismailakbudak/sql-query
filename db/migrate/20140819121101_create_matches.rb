class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
    
      t.integer :home_id
      t.integer :guest_id
      t.date    :match_date

      t.timestamps
    end
    
    add_index :matches, :home_id
    add_index :matches, :guest_id

  end
end
