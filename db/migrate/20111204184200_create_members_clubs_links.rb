class CreateMembersClubsLinks < ActiveRecord::Migration
  def self.up
    create_table :members_clubs do |t|
      t.integer :member_id, :null => false
      t.integer :club_id, :null => false
      t.datetime :member_since, :null => true
      t.integer :presence, :null => false, :default => 0
      t.boolean :is_licence_ok, :null => false, :default => true
      t.datetime :licence_end_date, :null => true
      t.boolean :is_insurance_ok, :null => false, :default => true
      t.datetime :insuruance_end_date, :null => true
      t.datetime :created_at, :null => false
      t.timestamp :updated_at, :null => false
    end
  end

  def self.down
    drop_table :members_clubs
  end
  
end