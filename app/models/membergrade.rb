class Membergrade < ActiveRecord::Base
  set_table_name :member_grades
  belongs_to :member
  belongs_to :art
  belongs_to :grade
  
  validates_uniqueness_of :grade_id, :scope => [:member_id, :art_id]
  validates :since_date, :presence => true
  validates :art_id, :presence => true
  validates :grade_id, :presence => true
  validates :member_id, :presence => true
  
  before_save :process_actual
  
  scope :is_current, where('is_actual = 1')
  
  def process_actual
    if (self.is_actual == 1)
      Membergrade.is_current.find_all_by_member_id_and_art_id(self.member_id, self.art_id).each do |o|
        o.is_actual = 0
        o.save
      end
    end
  end
  
end
