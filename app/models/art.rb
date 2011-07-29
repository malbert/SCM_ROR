class Art < ActiveRecord::Base
  has_many :grades
  belongs_to :club
end
