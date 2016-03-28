class Usuario::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
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
  
  # /usuarios/auth/{provider}/callback
  [:facebook, :google_oauth2].each do |provider|
    provides_callback_for provider
  end
  
  def validate_facebook_token
    access_token = params[:access_token]
    @graph = Koala::Facebook::API.new(access_token, 
      Rails.application.secrets.facebook_secret)
    begin 
      profile = @graph.get_object("me")
      omniauth = build_omniauth_hash(profile, access_token)
      @usuario = UsuarioProvider.usuario_from_omniauth(omniauth)
      
      if @usuario.persisted?
        sign_in @usuario, :event => :authentication
        render json: @usuario
      else
        render_json_error 'Usuario not persisted!', 500
      end
    rescue Exception=>ex
			render_json_error ex.message, 500
		end
  end
  
  def validate_google_token
    access_token = params[:access_token]
    # TODO
  end
  
  protected
  
  def build_omniauth_hash(profile, access_token)
    struct = OpenStruct.new
    struct.provider = 'facebook'
    struct.uid = profile['id']
    struct.info = OpenStruct.new
    struct.info.email = profile['email']
    struct.info.image = "http://graph.facebook.com/#{profile['id']}/picture?type=square"
    struct.info.first_name = profile['first_name']
    struct.info.last_name = profile['last_name']
    struct.info.name = profile['name']
    struct.info.bio = profile['bio']
    struct.info.hometown = profile['hometown']['name'] if profile['hometown']
    struct.info.location = profile['location']['name'] if profile['location']
    struct.credentials = OpenStruct.new
    struct.credentials.token = access_token
    struct.credentials.expires_at = 1.month.from_now
    struct
  end
  
  def render_json_error(message, status)
    render json: {
        success: false,
        errors: message
      }, status: status
  end
  
end
