class Usuario::PasswordsController < Devise::PasswordsController
  
  def new
    @title = "Olá esportista, <br/>entre com o email cadastrado!".html_safe
    super
  end
  
end