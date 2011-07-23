class CreateClubIndex < ActiveRecord::Migration
  def self.up
    
    add_index :clubs, :title
    add_index :clubs, :country
    add_index :clubs, :town
  end

  def self.down
    remove_index :clubs, :title
    remove_index :clubs, :country
    remove_index :clubs, :town
  end
end
