class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field = 'email'
  end
  
  def self.find_by_login_or_email(login)
   find_by_login(login) || find_by_email(login)
  end

end
