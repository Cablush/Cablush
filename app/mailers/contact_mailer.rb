class ContactMailer < ActionMailer::Base
  default :from => '"Cablush" <no-reply@cablush.com>'

  def contact_message(contact)
    @contact = contact
    mail(
      :to => 'contact@cablush.com', 
      :subject => 'Contato via site'
    )
  end
  
end
