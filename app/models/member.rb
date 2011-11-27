# To change this template, choose Tools | Templates
# and open the template in the editor.

class Member < ActiveRecord::Base
  has_many :memberclublinks
  has_many :clubs, :through => :memberclublinks
  
  validates :firstname, :presence => true
  validates :lastname, :presence => true
 
end