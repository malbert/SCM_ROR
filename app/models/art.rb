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
    new_art = Art.new
    new_art.club_id = club.id
    new_art.enabled = true
    new_art.template = false
    new_art.template_id = self.id
    new_art.name = self.name
    
    #new_art = self.clone
    #new_art.template = false
    #new_art.template_id = self.id
    #new_art.save
    #two-level association 
    self.grades.where(['language = ?', language]).each do |grade|
      #new_grade = grade.clone
      new_grade = Grade.new
      new_grade.template = false
      new_grade.age_minimum  = grade.age_minimum
      new_grade.grade_order = grade.grade_order
      new_grade.is_presence_required = grade.is_presence_required
      new_grade.presence_required = grade.presence_required
      new_grade.language = grade.language
      new_grade.name = grade.name
      
      new_grade.save
      new_art.grades << new_grade
    end
    new_art.save
    new_art
  end

end
