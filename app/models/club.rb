class Club < ActiveRecord::Base
  has_attached_file :logo, :styles => {
    :thumb => '40x', :small => '50x', :medium => '100x', :big => '200x'
  }
end
