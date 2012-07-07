class MembersClubsAddIndexes < ActiveRecord::Migration
  def up
    add_index :members_clubs, [:member_id, :club_id]
  end

  def down
    remove_index :members_clubs, [:member_id, :club_id]
  end
end
