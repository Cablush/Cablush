class Usuario::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  skip_before_filter :verify_authenticity_token
  
  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @usuario = UsuarioProvider.usuario_from_omniauth(request.env["omniauth.auth"])

        if @usuario.persisted?
          sign_in_and_redirect @usuario, event: :authentication
        else
          session["devise.#{provider}_data"] = env["omniauth.auth"]
          redirect_to new_usuario_registration_path
        end
      end
    }
  end
  
  # /omniauth/{provider}/callback
  [:facebook, :google_oauth2].each do |provider|
    provides_callback_for provider
  end

  def self.failure
    redirect_to new_usuario_registration_path
  end
  
end
