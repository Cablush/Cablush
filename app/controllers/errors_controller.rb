class ErrorsController < ApplicationController
  def not_found
    @title = I18n.t('error.not_found').html_safe
    render(status: 404)
  end

  def internal_server_error
    @title = I18n.t('error.internal_server_error').html_safe
    render(status: 500)
  end
end
