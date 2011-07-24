class CreateClubUserLink < ActiveRecord::Migration
  def self.up 
    add_column :clubs, :owner_id, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :clubs, :owner_id
  end
end
