class Member < ActiveRecord::Base
  has_many :membergrades, :dependent => :destroy
  has_many :clubs, :through => :clubmemberships
  has_many :clubmemberships, :dependent => :destroy
  
  validates :firstname, :presence => true
  validates :lastname, :presence => true
  
  default_scope order("lastname")
 
  def get_unique_arts()
    
    ids = []
    self.membergrades.find(:all, :select => "DISTINCT art_id").each{ |a|
      ids << a.art_id
    }
    return Art.find(ids, :order => "name ASC")
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