class Art < ActiveRecord::Base
  has_many :artgradelinks
  has_many :grades, :through => :artgradelinks
  belongs_to :club
  
  scope :active, where('enabled = 1')  
  scope :inactive, where('enabled = 0')
  scope :template, where('template = 1').order('name')
  
  def self.get_or_create_art_with_template(art_template_id, art_template_name, club, language)
      if (art_template_id)
         art_template = self.find(art_template_id)
       else
         #check on the name....in case of twice inputs
         art_template = self.find(:all, :conditions => ['name = ?', art_template_name]).first
       end
       
      if art_template
        new_art = art_template.apply_grade_template(club, language)
        new_art.club = club
        new_art.template = false
        new_art.template_id = art_template_id
        new_art.save
      else
        new_art_template = self.create(name: art_template_name, template: true)
        new_art = self.create(name: art_template_name, template: false, template_id: new_art_template.id, club: club)
      end
      new_art
  end
  
  def as_json(options = nil)
    super( options || {include: {:grades => {only: [:id, :name, :age_minimum, :presence_required]}}, only: [:id, :name]})
  end
  
  def apply_grade_template(club, language) 
    new_art = Art.create(club_id: club.id, enabled: true, template: false, name: self.name)

    #two-level association 
    self.grades.where(['language = ?', language]).each do |grade|
      new_art.grades.create(template: false, age_minimum: grade.age_minimum, grade_order: grade.grade_order, is_presence_required: grade.presence_required, language: grade.language, name: grade.name)  
    end
    new_art
  end

end
