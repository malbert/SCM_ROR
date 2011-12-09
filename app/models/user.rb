class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :userclublinks
  has_many :clubs, :through => :userclublinks
  
  acts_as_authentic do |c|
    c.login_field = 'email'
  end
  
  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true

  
  def self.find_by_login_or_email(login)
   logger.info "loggin " + login
   find_by_username(login) || find_by_email(login)
  end

  private
  def password_must_be_present
    errors.add(:password, t(:missing_password)) unless password.present?
  end
end
