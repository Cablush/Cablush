class UsuarioProvider < ApplicationRecord
  belongs_to :usuario, class_name: 'Usuario'

  def self.usuario_from_omniauth(auth)
    # find the provider
    provider = where(provider: auth.provider, uid: auth.uid).first
    unless provider.nil?
      # if provider exists, update the token and return the user
      logger.debug 'Provider exists.'
      provider.token = auth.credentials.token
      provider.expires_at = auth.credentials.expires_at
      provider.save!
      provider.usuario
    else
      # if provider does not exist, find the user
      usuario = Usuario.where(email: auth.info.email).first
      unless usuario.nil?
        # if the user exists, creates the provider, and return the user
        logger.debug 'User exists, creating Provider.'
        UsuarioProvider.create!(
          provider: auth.provider,
          uid: auth.uid,
          token: auth.credentials.token,
          expires_at: auth.credentials.expires_at,
          usuario_id: usuario.id
        )
        return usuario
      else
        # if the user does not exists, creates a new user skipping the
        # confirmation, creates the profile, and return the user
        logger.debug 'User does not exists, creating User and Provider.'
        usuario = Usuario.new(
          nome: auth.info.name,
          email: auth.info.email,
          password: Devise.friendly_token[0, 20]
        )
        usuario.skip_confirmation!
        usuario.save!
        provider = UsuarioProvider.create!(
          provider: auth.provider,
          uid: auth.uid,
          token: auth.credentials.token,
          expires_at: auth.credentials.expires_at,
          usuario_id: usuario.id
        )
        return usuario
      end
    end
  end
end
