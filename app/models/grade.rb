class Grade < ActiveRecord::Base
  has_many :artgradelinks, :dependent => :destroy
  has_many :arts, :through => :artgradelinks
  has_many :membergrades, :dependent => :destroy
  
  default_scope order('grade_order ASC') 
  
  scope :first_grade, where('grade_order = 1').limit(1).first
  
  def as_json(options = nil)
    super( options || {only: [:id, :name, :grade_order, :language, :age_minimum, :is_presence_required, :presence_required]})
  end
   
end
