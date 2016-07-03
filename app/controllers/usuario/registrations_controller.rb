class Usuario::RegistrationsController < Devise::RegistrationsController
  include EsportesUpdate

  before_action :configure_permitted_parameters

  def new
    @title = I18n.t('views.devise.cadastrar_title').html_safe
    super
  end

  def create
    super do
      begin
        if resource.lojista == '1'
          resource.lojista!
        else
          resource.esportista!
        end
        resource.save
      rescue
        @erro_msg = I18n.t 'views.devise.cadastrar_error'
      end
    end
  end

  def edit
    @title = I18n.t('views.devise.editar_title',
                    usuario: current_usuario.nome).html_safe
    super
  end

  def update
    update_esporte_ids(params['usuario'])
    super
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up,
                                      keys: [:nome, :email, :password,
                                             :password_confirmation, :lojista]
    devise_parameter_sanitizer.permit :account_update,
                                      keys: [:nome, :email, :current_password,
                                             :password, :password_confirmation,
                                             esporte_ids: []]
  end

  def after_sign_up_path_for(resource)
    index_path
  end

  def after_update_path_for(resource)
    edit_usuario_registration_path
  end
end
