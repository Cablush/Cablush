class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if current_usuario.admin?
      home_index_admin_path
    elsif current_usuario.lojista?
      home_index_lojista_path
    else
      home_index_path
    end
  end
  
  def after_sign_out_path_for(resource)
    home_index_path
  end
  
  protected
  
  def lojista_at_least
    unless current_usuario.lojista? || current_usuario.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end
  
  def admin_only
    unless current_usuario.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end
  
end
