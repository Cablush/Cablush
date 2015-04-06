class ContactMailer < ActionMailer::Base
  default :from => 'jhonnybat@gmail.com'

  def contact_message(contact)
    @contact = contact
    mail(:to => 'jhonnybat@gmail.com', :subject => 'Mensagem de Contato')
  end
end
