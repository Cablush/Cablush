namespace :usuario do
  task :resend_confirmation => :environment do
    usuarios = Usuario.where('confirmation_token IS NOT NULL')
    usuarios.each do |usuario|
      usuario.send_confirmation_instructions
    end
  end
end
