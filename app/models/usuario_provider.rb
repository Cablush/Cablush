class UsuarioProvider < ActiveRecord::Base
  belongs_to :usuario
  
  def self.usuario_from_omniauth(auth)
    provider = where(provider: auth.provider, uid: auth.uid).first
    
    unless provider.nil?
        provider.usuario
    else
      usuario = Usuario.where(:email => auth.info.email).first
      unless usuario.nil?
        UsuarioProvider.create!(
          provider: auth.provider, 
          uid: auth.uid, 
          token: auth.credentials.token, 
          expires_at: auth.credentials.expires_at, 
          usuario_id: usuario.id
        )
        usuario
      else
        usuario = Usuario.create!(
          nome: auth.info.name,
          email: auth.info.email,
          password: Devise.friendly_token[0,20],
        )
        provider = UserProvider.create!(
          provider: auth.provider,
          uid: auth.uid,
          token: auth.credentials.token,
          expires_at: auth.credentials.expires_at,
          usuario_id: usuario.id
        )
        usuario
      end
    end
  end
  
#  def self.new_with_session(params, session)
#    super.tap do |usuario|
#      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
#        usuario.email = data["email"] if usuario.email.blank?
#      end
#    end
#  end

end
