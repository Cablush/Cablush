class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def after_sign_in_path_for(resource)
    home_cadastros_path
  end
  
  def after_sign_out_path_for(resource)
    home_index_path
  end
  
  def unauthorized
    @title = "Acesso não autorizado, por favor efetue login e tente novamente."
    return :file => File.join(Rails.root, 'public/401'), :formats => [:html], :status => 401
  end
  
  def forbidden
    @title = "Acesso não permitido."
    return :file => File.join(Rails.root, 'public/403'), :formats => [:html], :status => 403
  end
  
  def not_found
    @title = "Página não encontrada."
    return :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404
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
