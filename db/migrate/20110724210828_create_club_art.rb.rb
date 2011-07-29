class CreateClubArt < ActiveRecord::Migration
  def self.up
    add_column :arts, :club_id, :integer, :null => true
    add_column :arts, :template_id, :integer, :null => true
  end

  def self.down
    remove_column :arts, :club_id
  end
end
