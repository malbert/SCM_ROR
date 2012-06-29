class Club < ActiveRecord::Base
  has_many :userclublinks, :dependent => :destroy 
  has_many :users, :through => :userclublinks
  
  has_many :clubmemberships, :dependent => :destroy
  has_many :members, :through => :clubmemberships
  
  has_many :arts, :dependent => :destroy
  
  has_and_belongs_to_many :events, :uniq => true
  
  has_attached_file :logo, :styles => {
    :thumb => '40x', :small => '50x', :medium => '100x', :big => '200x'
  }
  
  def fill_by_defaults(_accessibility, _schedule)
    if (accessibility == nil)
      self.accessibility = _accessibility
    end

    if (schedule == nil)
        self.schedule = _schedule
    end
        
    if (contact  == nil)
      club_owner = User.find_by_id(owner_id)
      contact_example = club_owner.firstname + " " + club_owner.lastname + "\n"
      contact_example += "Tel : \n"
      contact_example += "email : " + club_owner.email
      self.contact = contact_example
    end
  end
  
  def get_available_arts_template
    arts = self.arts.active.all
    if (arts.count > 0)
      available_arts = Art.template.find( :all, :conditions => ['id not in (?)', arts.map(&:template_id)])
    else
      available_arts = Art.template.all
    end
    available_arts
  end
  
end
