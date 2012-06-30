class Member < ActiveRecord::Base
  has_many :membergrades, :dependent => :destroy
  has_many :clubs, :through => :clubmemberships
  has_many :clubmemberships, :dependent => :destroy
  
  validates :firstname, :presence => true
  validates :lastname, :presence => true
  
  default_scope order("lastname")
 
  def self.find_or_create(params)
    member = Member.find_by_email(params[:email])
    if (!member)
       member = Member.create(params)
     end
     member
  end
  
  def get_unique_arts()
    ids = []
    self.membergrades.find(:all, :select => "DISTINCT art_id").each{ |a|
      ids << a.art_id
    }
    return Art.find(ids, :order => "name ASC")
  end
  
  def add_member_to_club(club)
    membership = self.clubmemberships.find_all_by_club_id(club);
    # the member doesn't already exist for this club
    if (membership.count == 0)
      self.clubs << club
      club.arts.includes(:grades).active.each do |art|
        first_grade = art.grades.first
        self.membergrades.create(art_id: art.id, grade_id: first_grade.id)
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
  
  def as_json(options = nil)
    super( options || {only: [:id, :firstname, :lastname, :birthdate, :email, :phone]})
  end
  
end