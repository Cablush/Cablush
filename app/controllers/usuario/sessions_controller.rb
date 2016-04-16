class Usuario::SessionsController < Devise::SessionsController
  
  acts_as_token_authentication_handler_for Usuario, only: [:validate_token]
  
  def new
    @title = "Olá esportista, <br/>entre com seus dados de login!".html_safe
    super
  end
  
  def validate_token
    # simple_token_authentication gem verifies the header values
    if usuario_signed_in?
      render json: current_usuario
    else
      render json: {
        success: false,
        errors: 'Please, login before continue!'
      }, status: 401
    end
  end
  
end