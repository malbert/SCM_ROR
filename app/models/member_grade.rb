class MemberGrade < ActiveRecord::Base
  has_one :member
  has_one :art
  has_one :grade
   
end
