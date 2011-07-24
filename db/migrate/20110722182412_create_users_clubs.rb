class CreateUsersClubs < ActiveRecord::Migration
  def self.up 
    create_table :users_clubs do |t|
      t.string :user_id, :null => false, :default => 0
      t.string :club_id, :null => false, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :users_clubs
  end
end
