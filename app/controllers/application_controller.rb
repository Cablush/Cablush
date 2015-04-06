class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  def after_sign_in_path_for(resource)
    if current_usuario.logista?
      home_cadastro_path
    else
      home_index_path
    end  
  end
  
  def after_sign_up_path_for(resource)
    if current_usuario.logista?
      home_cadastro_path
    else
      home_index_path
    end  
  end

  def after_sign_out_path_for(resource)
    home_index_path
  end
  
   before_filter :configure_permitted_parameters, if: :devise_controller?
  ## ...

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:usuario, :logista, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:usuario, :logista, :email, :password, :current_password, :password_confirmation) } 
  end
  
end
