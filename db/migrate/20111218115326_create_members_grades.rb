class CreateMembersGrades < ActiveRecord::Migration
  def self.up
    create_table :members_grades do |t|
      t.integer :member_id, :null => false
      t.integer :art_id, :null => false
      t.integer :grade_id, :null => false
      t.datetime :since_date, :null => true
      t.boolean :is_actual, :null => false, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :members_grades
  end
  
end