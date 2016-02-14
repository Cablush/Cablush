class Api::LojasController < Api::ApiController
	
  before_action :authenticate_usuario!, only: [:mine, :create, :update]
  
  # GET /lojas
  def index
    lojas = Loja.find_like_name(params['nome'])
    lojas = lojas.find_by_estado(params['estado'])
    lojas = lojas.find_by_esporte_categoria(params['esporte'])
    
    render json: lojas, 
      :except => [:id, :created_at, :responsavel_id, :logo_file_name, :logo_content_type, :logo_file_size, :logo_updated_at],
      :methods => [:logo_url],
      :include => {
        :locais => {:except => [:id, :created_at, :updated_at, :localizavel_id, :localizavel_type]},
        :esportes => {:except => [:created_at, :updated_at]},
        :horario => {:except => [:id, :created_at, :updated_at, :funcionamento_id, :funcionamento_type]}
      }
  end
  
  # GET /lojas/mine
  def mine
    lojas = Loja.where(responsavel_id: current_usuario.id)
    
    render json: lojas, 
      :except => [:id, :created_at, :responsavel_id, :logo_file_name, :logo_content_type, :logo_file_size, :logo_updated_at],
      :methods => [:logo_url, :responsavel_uuid],
      :include => {
        :locais => {:except => [:id, :created_at, :updated_at, :localizavel_id, :localizavel_type]},
        :esportes => {:except => [:created_at, :updated_at]},
        :horario => {:except => [:id, :created_at, :updated_at, :funcionamento_id, :funcionamento_type]}
      }
  end
  
  # POST /lojas(.:format)
  def create
    if current_usuario.admin?
      loja = Loja.new(loja_params)
    else
      loja = current_usuario.lojas.build(loja_params)
    end
    
    if loja.save
      render json: loja, 
        :except => [:id, :created_at, :responsavel_id, :logo_file_name, :logo_content_type, :logo_file_size, :logo_updated_at],
        :methods => [:logo_url, :responsavel_uuid],
        :include => {
          :locais => {:except => [:id, :created_at, :updated_at, :localizavel_id, :localizavel_type]},
          :esportes => {:except => [:created_at, :updated_at]},
          :horario => {:except => [:id, :created_at, :updated_at, :funcionamento_id, :funcionamento_type]}
        }
    else
      render json: loja.errors
    end
  end
  
  # PATCH/PUT /lojas/:uuid
  def update
    if current_usuario.admin?
      loja = Loja.find_by_uuid!(params[:uuid])
    else
      loja = current_usuario.lojas.find_by_uuid!(params[:uuid])
    end
    
    if loja.update(loja_params)
      render json: loja, 
        :except => [:id, :created_at, :responsavel_id, :logo_file_name, :logo_content_type, :logo_file_size, :logo_updated_at],
        :methods => [:logo_url, :responsavel_uuid],
        :include => {
          :locais => {:except => [:id, :created_at, :updated_at, :localizavel_id, :localizavel_type]},
          :esportes => {:except => [:created_at, :updated_at]},
          :horario => {:except => [:id, :created_at, :updated_at, :funcionamento_id, :funcionamento_type]}
        }
    else
      render json: loja.errors
    end
  end

  private
  
  def loja_params
    params.require(:loja).permit(:uuid, :nome, :telefone, :email, :website, :facebook, :logo, :fundo, :descricao, :updated_at,
              esporte_ids: [],
              locais_attributes: [:latitude, :longitude, :logradouro, :numero, :complemento, :bairro, :cidade, :estado, :cep, :pais], 
              horario_attributes: [:seg, :ter, :qua, :qui, :sex, :sab, :dom, :inicio, :fim, :detalhes])
  end
  
end
