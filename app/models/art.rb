class Art < ActiveRecord::Base
  has_many :artgradelinks
  has_many :grades, :through => :artgradelinks
  belongs_to :club
  
  def as_json(options={}) 
     {
       :id => id,
       :name => name,
       :grades => grades
     }
   end

end
