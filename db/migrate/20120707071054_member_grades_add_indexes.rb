class MemberGradesAddIndexes < ActiveRecord::Migration
  def up
    add_index :member_grades, [:member_id, :art_id, :grade_id, :is_actual], :name => 'member_grades_index_01'
  end

  def down
    remove_index :member_grades, [:member_id, :art_id, :grade_id, :is_actual], :name => 'member_grades_index_01'
  end
end
