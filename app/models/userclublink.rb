class Userclublink < ActiveRecord::Base
  set_table_name :users_clubs
  belongs_to :user
  belongs_to :club
   
end
