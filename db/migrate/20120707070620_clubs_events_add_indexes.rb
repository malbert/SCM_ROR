class ClubsEventsAddIndexes < ActiveRecord::Migration
  def up
    add_index :clubs_events, [:club_id, :event_id]
  end

  def down
    remove_index :clubs_events, [:club_id, :event_id]
  end
end
