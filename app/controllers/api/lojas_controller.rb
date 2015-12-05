class Api::LojasController < Api::ApiController
	
  before_action :authenticate_usuario!
  
  # GET /lojas
  def index
    lojas = Loja.find_like_name(params['nome'])
    lojas = lojas.find_by_estado(params['estado'])
    lojas = lojas.find_by_esporte_id(params['esporte'])
    
    render json: lojas, 
      :except => [:id, :created_at, :updated_at, :responsavel_id, :logo_updated_at],
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
        :except => [:id, :created_at, :updated_at, :responsavel_id, :logo_updated_at],
        :include => {
          :locais => {:except => [:id, :created_at, :updated_at, :localizavel_id, :localizavel_type]},
          :esportes => {:except => [:created_at, :updated_at]},
          :horario => {:except => [:id, :created_at, :updated_at, :funcionamento_id, :funcionamento_type]}
        }
    else
      render json: loja.errors
    end
  end
  
  # GET /lojas/:id
  def show
    loja = Loja.find_by_uuid!(params[:id])
    render json: loja, 
      :except => [:id, :created_at, :updated_at, :responsavel_id, :logo_updated_at],
      :include => {
        :locais => {:except => [:id, :created_at, :updated_at, :localizavel_id, :localizavel_type]},
        :esportes => {:except => [:created_at, :updated_at]},
        :horario => {:except => [:id, :created_at, :updated_at, :funcionamento_id, :funcionamento_type]}
      }
  end
  
  # PATCH/PUT /lojas/:id
  def update
    if current_usuario.admin?
      loja = Loja.find_by_uuid!(params[:id])
    else
      loja = current_usuario.lojas.find_by_uuid!(params[:id])
    end
    
    if loja.update(loja_params)
      render json: loja, 
        :except => [:id, :created_at, :updated_at, :responsavel_id, :logo_updated_at],
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
    params.require(:loja).permit(:nome, :telefone, :email, :website, :facebook, :logo, :fundo, :descricao, 
              esporte_ids: [],
              locais_attributes: [:id, :latitude, :longitude, :logradouro, :numero, :complemento, :bairro, :cidade, :estado, :cep, :pais], 
              horario_attributes: [:id, :seg, :ter, :qua, :qui, :sex, :sab, :dom, :inicio, :fim, :detalhes])
  end
  
end
