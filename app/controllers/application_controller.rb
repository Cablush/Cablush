class ApplicationController < ActionController::Base
  include HttpAcceptLanguage::AutoLocale

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, if: Proc.new { |c|
    c.request.format == 'application/json'
  }

  # Used by impressionist
  def current_user
    current_usuario if current_usuario.present?
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
    unless current_usuario.present? && (current_usuario.lojista? ||
    current_usuario.admin?)
      redirect_to :back, alert: I18n.t('message.denied')
    end
  end

  def admin_only
    unless current_usuario.present? && current_usuario.admin?
      redirect_to cadastros_path, alert: I18n.t('message.denied')
    end
  end

  def render_json_resource(resource)
    render json: resource
  end

  def render_json_success(resource, status, message = '')
    render json: {
      success: true,
      data: resource,
      message: message
    }, status: status
  end

  def render_json_error(error, status)
    logger.error error.is_a?(ActiveModel::Errors) ? error.messages : error
    render json: {
      success: false,
      message: error
    }, status: status
  end
end
