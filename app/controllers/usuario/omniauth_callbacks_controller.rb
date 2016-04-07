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
    @graph = Koala::Facebook::API.new(access_token, Rails.application.secrets.facebook_secret)
    begin 
      profile = @graph.get_object("me")
      omniauth = omniauth_hash_from_facebook(profile, access_token)
      authenticate_omniauth(omniauth)
    rescue Exception=>ex
			render_json_error ex.message, 500
		end
  end
  
  def validate_google_token
    access_token = params[:access_token]
    response = HTTParty.get("https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=" + access_token)
    if response.code == 200
      data = JSON.parse(response.body)
      if (data['aud'] == Rails.application.secrets.google_key)
        omniauth = omniauth_hash_from_google(data, access_token)
        authenticate_omniauth(omniauth)
      else
        render_json_error 'Invalid client id!', 500
      end
    else 
      render_json_error 'Error validating token!', 500
    end
  end

  protected
  
  def authenticate_omniauth(omniauth)
    @usuario = UsuarioProvider.usuario_from_omniauth(omniauth)
      
    if @usuario.persisted?
      sign_in @usuario, :event => :authentication
      render json: @usuario
    else
      render_json_error 'Error persisting Usuario!', 500
    end
  end
  
  def omniauth_hash_from_facebook(profile, access_token)
    struct = OpenStruct.new
    struct.provider = 'facebook'
    struct.uid = profile['id']
    struct.info = OpenStruct.new
    struct.info.email = profile['email']
    struct.info.name = profile['name']
    struct.info.first_name = profile['first_name']
    struct.info.last_name = profile['last_name']
    struct.info.image = "http://graph.facebook.com/#{profile['id']}/picture?type=square"
    struct.credentials = OpenStruct.new
    struct.credentials.token = access_token
    struct.credentials.expires_at = 1.hours.from_now.to_i
    struct
  end
  
  def omniauth_hash_from_google(tokeninfo, access_token)
    struct = OpenStruct.new
    struct.provider = 'google_oauth2'
    struct.uid = tokeninfo['sub']
    struct.info = OpenStruct.new
    struct.info.email = tokeninfo['email']
    struct.info.name = tokeninfo['name']
    struct.info.first_name = tokeninfo['given_name']
    struct.info.last_name = tokeninfo['family_name']
    struct.info.image = tokeninfo['picture']
    struct.credentials = OpenStruct.new
    struct.credentials.token = access_token
    struct.credentials.expires_at = tokeninfo['exp']
    struct
  end
  
  def render_json_error(message, status)
    render json: {
        success: false,
        errors: message
      }, status: status
  end
  
end
