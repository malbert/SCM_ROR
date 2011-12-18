class Club < ActiveRecord::Base
  has_many :userclublinks 
  has_many :users, :through => :userclublinks
  
  has_many :clubmemberships
  has_many :members, :through => :clubmemberships
  
  has_many :arts
  
  has_and_belongs_to_many :events, :uniq => true
  
  has_attached_file :logo, :styles => {
    :thumb => '40x', :small => '50x', :medium => '100x', :big => '200x'
  }
  
end
