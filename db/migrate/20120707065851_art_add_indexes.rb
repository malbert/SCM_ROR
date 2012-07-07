class ArtAddIndexes < ActiveRecord::Migration
  def up
    add_index :arts, :name
    add_index :arts, :club_id
    add_index :arts, :enabled
  end

  def down
    remove_index :arts, :name
    remove_index :arts, :club_id
    remove_index :arts, :enabled
  end
end
