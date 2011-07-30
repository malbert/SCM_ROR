class Grade < ActiveRecord::Base
  has_many :artgradelinks
  has_many :arts, :through => :artgradelinks
  
  def as_json(options={}) 
     {
       :id => id,
       :name => name,
       :grade_order => grade_order,
       :language => language,
       :age_minimum => age_minimum,
       :is_presence_required => is_presence_required,
       :presence_required =>  presence_required
     }
   end
   
end
