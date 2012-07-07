class ArtGradeLinkAddIndexes < ActiveRecord::Migration
  def up
    add_index :arts_grades, [:art_id, :grade_id]
  end

  def down
    remove_index :arts_grades, [:art_id, :grade_id]
  end
end
