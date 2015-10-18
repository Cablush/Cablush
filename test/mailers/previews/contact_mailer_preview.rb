# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview

  def contact_mail_preview
    contact = JSON.parse('{"name":"Josef Climber", "email":"j_climber@osmelhoresdomundo.com.br", "subject":"A vida é uma caixinha de surpresas", "message":"Qualquer um de nós ficaria chateado, qualquer um de nós ficaria desmotivado, mas este é Josef Climber...."}')
    ContactMailer.contact_message(contact)
  end
end
