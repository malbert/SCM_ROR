class CourseHistoryAddIndexes < ActiveRecord::Migration
  def up
    add_index :grades, [:id, :grade_order, :language]
  end

  def down
    remove_index :grades, [:id, :grade_order, :language]
  end
end
