class Usuario::SessionsController < Devise::SessionsController
  
  def new
    @title = "Olá esportista, <br/>entre com seus dados de login!".html_safe
    super
  end
  
  def self.validate_token
    # TODO
  end
  
end