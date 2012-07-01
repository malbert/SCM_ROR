class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :userclublinks, :dependent => :destroy
  has_many :clubs, :through => :userclublinks
  has_many :clubmemberships, :through => :clubs
  has_many :members, :through => :clubmemberships
  
  #attr_accessible :id, :firstname, :lastname, :username, :email, :address, :town, :zip, :country, :language, :crypted_password, :password_salt
  attr_protected :last_login_at, :admin
  
  acts_as_authentic do |c|
    c.login_field = 'email'
  end
  
  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true

  
  def self.find_by_login_or_email(login)
   logger.info "loggin " + login
   find_by_username(login) || find_by_email(login)
  end

  def prepare_for_update
      language = Language.find_by_code(self.language);
      self.language = language.id;

      country = Country.find_by_iso(self.country); 
      self.country = country.id;
      self.password = nil
  end

  private
  def password_must_be_present
    errors.add(:password, t(:missing_password)) unless password.present?
  end
end
