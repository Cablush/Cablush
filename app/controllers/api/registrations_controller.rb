class Api::RegistrationsController < DeviseTokenAuth::RegistrationsController
  
  before_action :configure_permitted_parameters
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do 
      |u| u.permit(:nome, :email, :password, :lojista)
    end
    devise_parameter_sanitizer.for(:account_update) do 
      |u| u.permit(:nome, :email, :current_password, :password, esporte_ids: [])
    end
  end
  
end
