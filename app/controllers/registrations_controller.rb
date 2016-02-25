class RegistrationsController < Devise::RegistrationsController
  
  include EsporteAutocompletes
  
  before_action :configure_permitted_parameters
  
  def new
    @title = "Bem vindo esportista, <br/>faça o cadastro para compartilhar seus locais favoritos!".html_safe
    super
  end
  
  def create
    super do
      begin
        if resource.lojista == "1"
          resource.lojista! 
        elsif
          resource.esportista!
        end
          resource.save
      rescue
        @erro_msg = "Ocorreu um erro ao salvar usuário, por favor tente novamente!"
      end
    end
  end
  
  def edit
    @title = (current_usuario.nome + ",<br/> aqui você pode editar seu dados cadastrais<br/> e informações pessoais.").html_safe
    super
  end
  
  def update
    update_esporte_ids(params["usuario"])
    super
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do 
      |u| u.permit(:nome, :email, :password, :password_confirmation, :lojista)
    end
    devise_parameter_sanitizer.for(:account_update) do 
      |u| u.permit(:nome, :email, :current_password, :password, :password_confirmation, 
                   esporte_ids: [])
    end
  end
  
  def after_sign_up_path_for(resource)
      index_path
  end
  
  def after_update_path_for(resource)
      edit_usuario_registration_path
  end
  
end