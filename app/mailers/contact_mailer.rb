class ContactMailer < ActionMailer::Base
  default from: "contactus@michaelalbert.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.name.subject
  #

  def contactus(name, email, message)
    
    @message = message
    @name = name
    mail from: email, to: "monstermick@gmail.com", subject: "SCM - Someone contacts you"
  end

  
end
