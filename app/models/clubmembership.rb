class ClubMembership < ActiveRecord::Base
  set_table_name :members_clubs
  belongs_to :member
  belongs_to :clubs
   
end
