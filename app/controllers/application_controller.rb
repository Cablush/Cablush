class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  def unauthorized
    @title = I18n.t 'message.unauthorized'
    return :file => File.join(Rails.root, 'public/401'), :formats => [:html], :status => 401
  end

  def forbidden
    @title = I18n.t 'message.forbidden'
    return :file => File.join(Rails.root, 'public/403'), :formats => [:html], :status => 403
  end

  def not_found
    @title = I18n.t 'message.not_found'
    return :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404
  end

  # Used by impressionist
  def current_user
    current_usuario
  end

  protected

  def after_sign_in_path_for(resource)
    cadastros_path
  end

  def after_sign_out_path_for(resource)
    index_path
  end

  def after_omniauth_failure_path_for(scope)
    new_usuario_registration_path
  end

  def lojista_at_least
    unless current_usuario.lojista? || current_usuario.admin?
      redirect_to :back, alert: I18n.t('message.denied')
    end
  end

  def admin_only
    unless current_usuario.admin?
      redirect_to :back, alert: I18n.t('message.denied')
    end
  end

  def render_json_resource(resource)
    render json: resource
  end

  def render_json_success(resource, status)
    render json: {
        success: true,
        data: resource
      }, status: status
  end

  def render_json_error(message, status)
    render json: {
        success: false,
        errors: message
      }, status: status
  end

end
