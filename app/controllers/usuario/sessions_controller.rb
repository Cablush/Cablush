class Usuario::SessionsController < Devise::SessionsController
  
  acts_as_token_authentication_handler_for Usuario, only: [:validate_token]
  
  def new
    @title = "Olá esportista, <br/>entre com seus dados de login!".html_safe
    super
  end
  
  def validate_token
    # simple_token_authentication gem verifies the header values
    render json: current_usuario
  end
  
end