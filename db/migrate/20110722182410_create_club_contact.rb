class CreateClubContact < ActiveRecord::Migration
  def self.up 
    add_column :clubs, :accessibility, :text, :null => true
    add_column :clubs, :contact, :text, :null => true
  end

  def self.down
    remove_column :clubs, :accessibility
    remove_column :clubs, :contact
  end
end
