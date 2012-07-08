class Member < ActiveRecord::Base
  has_many :membergrades, :dependent => :destroy
  has_many :clubs, :through => :clubmemberships
  has_many :clubmemberships, :dependent => :destroy
  has_many :users
  
  validates :firstname, :presence => true
  validates :lastname, :presence => true
  validates :birthdate, :presence => true
  
  default_scope order("lastname")
  
  scope :should_pay, where('1=1')
 
  def self.find_or_create(params)
    member = Member.find_by_email(params[:email])
    if (!member)
       member = Member.create(params)
     end
     member
  end
  
  def get_unique_arts(club)
    ids = []
    arts = self.membergrades.find(:all, :select => "DISTINCT art_id")
    logger.debug 'club'
    logger.debug club
    arts_from_club = club.arts.find(:all, :select => "DISTINCT id")
    
    arts.each{ |a|
      ids << a.art_id
    }
    return Art.find(ids) & arts_from_club
  end
  
  def add_member_to_club(club)
    membership = self.clubmemberships.find_all_by_club_id(club);
    # the member doesn't already exist for this club
    if (membership.count == 0)
      self.clubs << club
      club.arts.active.find_each do |art|
        first_grade = art.grades.first
        self.membergrades.create(art_id: art.id, grade_id: first_grade.id, is_actual: true)
      end
      self.save
    end
  end
  
  def create_or_enable_membergrades(art)
    membergrade = self.membergrades.where("art_id = ? ", art.id)
    if (!membergrade)
      membergrade = Membergrade.new(art: art, is_actual: false, member: self)
      membergrade.save;
    end
  end
  
  
  def get_available_grades_for_art(art)
    actual_grade = self.get_actual_grade_for_art(art)
    art.get_superior_grades_of_level(actual_grade.grade_order)
  end
  
  def as_json(options = nil)
    super( options || {only: [:id, :firstname, :lastname, :birthdate, :email, :phone]})
  end
  
  #private
  
  def get_actual_grade_for_art(art)
    self.membergrades.is_current.find_by_art_id(art).grade
  end
end