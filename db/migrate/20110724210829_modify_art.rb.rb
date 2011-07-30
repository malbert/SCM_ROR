class ModifyArt < ActiveRecord::Migration
  def self.up
    add_column :arts, :enabled, :boolean, :null => false, :default => 1
  end

  def self.down
    remove_column :arts, :enabled
  end
end
