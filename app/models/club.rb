class Club < ActiveRecord::Base
  has_many :clubmemberships
  has_many :users, :through => :userclublinks
  
  has_many :memberclublinks
  has_many :members, :through => :clubmemberships
  
  has_many :arts
  
  has_attached_file :logo, :styles => {
    :thumb => '40x', :small => '50x', :medium => '100x', :big => '200x'
  }
  
end
