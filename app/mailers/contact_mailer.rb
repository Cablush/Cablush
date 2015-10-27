class ContactMailer < ActionMailer::Base
  default :from => '"Cablush" <cablush@cablush.com>'

  def contact_message(contact)
    @contact = contact
    mail(
      :to => 'cablush@cablush.com', 
      :subject => 'Contato via site'
    )
  end
  
end
