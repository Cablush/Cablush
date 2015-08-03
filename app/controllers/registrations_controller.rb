class RegistrationsController < Devise::RegistrationsController
  
  before_filter :configure_permitted_parameters
  
  def create
    super do
      resource.role = resource.lojista == "1" ? Usuario.lojista : Usuario.esportista
      resource.save
    end
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do 
      |u| u.permit(:nome, :email, :password, :password_confirmation, :lojista)
    end
    devise_parameter_sanitizer.for(:account_update) do 
      |u| u.permit(:nome, :email, :current_password, :password, :password_confirmation)
    end
  end
  
end