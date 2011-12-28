class Membergrade < ActiveRecord::Base
  set_table_name :member_grades
  belongs_to :member
  belongs_to :art
  belongs_to :grade
  
  validates_uniqueness_of :grade_id, :scope => [:member_id, :art_id]
   
end
