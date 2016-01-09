class Api::RegistrationsController < DeviseTokenAuth::RegistrationsController
  
  include EsporteAutocompletes
  
  def create
    super do |resource|
      if params[:lojista]
        puts "TRUE"
        resource.lojista!
      elsif
        puts "FALSE"
        resource.esportista!
      end
      resource.save
    end
  end
  
  def update
    update_esporte_ids(params)
    super
  end
  
  def sign_up_params
    params.permit(:nome, :email, :password, :password_confirmation, :lojista)
  end

  def account_update_params
    params.permit(:nome, :email, :current_password, :password, 
                  :password_confirmation, esporte_ids: [])
  end
  
end
