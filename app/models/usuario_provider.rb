class UsuarioProvider < ActiveRecord::Base
  belongs_to :usuario
  
  def self.usuario_from_omniauth(auth)
    # find the provider
    provider = where(provider: auth.provider, uid: auth.uid).first
    unless provider.nil?
        # if provider exists, return the user
        provider.usuario
    else
      # if provider does not exist, find the user
      usuario = Usuario.where(:email => auth.info.email).first
      unless usuario.nil?
        # if the user exists, creates the provider, and return the user
        UsuarioProvider.create!(
          provider: auth.provider, 
          uid: auth.uid, 
          token: auth.credentials.token, 
          expires_at: auth.credentials.expires_at, 
          usuario_id: usuario.id
        )
        usuario
      else
        # if the user does not exists, 
        # creates a new user skipping the confirmation, 
        # creates the profile, and return the user
        usuario = Usuario.new(
          nome: auth.info.name,
          email: auth.info.email,
          password: Devise.friendly_token[0,20],
        )
        usuario.skip_confirmation!
        usuario.save
        provider = UsuarioProvider.create!(
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
