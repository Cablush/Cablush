class Usuario::PasswordsController < Devise::PasswordsController

  def new
    @title = I18n.t('views.devise.change_password_title').html_safe
    super
  end

end
