class Member < ActiveRecord::Base
  has_many :membergrades
  has_many :clubs, :through => :clubmemberships
  has_many :clubmemberships
  
  validates :firstname, :presence => true
  validates :lastname, :presence => true
 
  def get_unique_arts()
    
    ids = []
    self.membergrades.find(:all, :select => "DISTINCT art_id").each{ |a|
      ids << a.art_id
    }
    return Art.find(ids, :order => "name ASC")
  end
  
  def as_json(options={}) 
     {
       :id => id,
       :firstname => firstname,
       :lastname => lastname,
       :birthdate => birthdate,
       :email => email,
       :phone => phone
     }
   end
end