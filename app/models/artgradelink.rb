class Artgradelink < ActiveRecord::Base
  set_table_name :arts_grades
  belongs_to :art
  belongs_to :grade
   
end
