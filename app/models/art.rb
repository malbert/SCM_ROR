class Art < ActiveRecord::Base
  has_many :artgradelinks
  has_many :grades, :through => :artgradelinks
  belongs_to :club
  
  def as_json(options={}) 
     {
       :id => id,
       :name => name,
       :grades => grades
     }
  end
  
  def apply_grade_template(club, language) 
    new_art = self.clone
    new_art.template = false
    new_art.template_id = self.id
    new_art.save
    #two-level association 
    self.grades.where(['language = ?', language]).each do |grade|
      new_grade = grade.clone :excluded => :id
      new_grade.template = false
      logger.info new_grade
      
      new_grade.save
      new_art.grades << new_grade
    end
    new_art.save
    new_art
  end

end
