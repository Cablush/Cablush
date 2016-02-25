class SessionsController < Devise::SessionsController
  
  def new
    @title = "Olá esportista, <br/>entre com seus dados de login!".html_safe
    super
  end
  
end