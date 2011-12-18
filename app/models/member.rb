class Member < ActiveRecord::Base
  has_many :clubmemberships
  has_many :clubs, :through => :clubmemberships
  has_many :membergrades
  
  validates :firstname, :presence => true
  validates :lastname, :presence => true
 
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