class CreateClubsEvents < ActiveRecord::Migration
  def self.up
    create_table :clubs_events do |t|
      t.integer :club_id, :null => false
      t.integer :event_id, :null => false
    end
  end

  def self.down
    drop_table :clubs_events
  end
  
end