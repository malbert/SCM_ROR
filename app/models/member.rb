# To change this template, choose Tools | Templates
# and open the template in the editor.

class Member < ActiveRecord::Base
  has_many :clubmemberships
  has_many :clubs, :through => :clubmemberships
  
  validates :firstname, :presence => true
  validates :lastname, :presence => true
 
end