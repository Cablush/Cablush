class Api::PistasController < Api::ApiController
  
  before_action :authenticate_usuario!, only: [:my, :create, :update]
  
  # GET /pistas
  def index
    pistas = Pista.find_like_name(params['nome'])
    pistas = pistas.find_by_estado(params['estado'])
    pistas = pistas.find_by_esporte_categoria(params['esporte'])
    
    render json: pistas, 
      :except => [:id, :created_at, :responsavel_id, :foto_file_name, :foto_content_type, :foto_file_size, :foto_updated_at],
      :methods => [:foto_url],
      :include => { 
        :local => {:except => [:id, :created_at, :updated_at, :localizavel_id, :localizavel_type]},
        :esportes => {:except => [:created_at, :updated_at]},
        :horario => {:except => [:id, :created_at, :updated_at, :funcionamento_id, :funcionamento_type]}
      }
  end
  
  # GET /pistas/mine
  def mine
    pistas = current_usuario.pistas
    
    render json: pistas, 
      :except => [:id, :created_at, :responsavel_id, :foto_file_name, :foto_content_type, :foto_file_size, :foto_updated_at],
      :methods => [:foto_url, :responsavel_uuid],
      :include => { 
        :local => {:except => [:id, :created_at, :updated_at, :localizavel_id, :localizavel_type]},
        :esportes => {:except => [:created_at, :updated_at]},
        :horario => {:except => [:id, :created_at, :updated_at, :funcionamento_id, :funcionamento_type]}
      }
  end

  # POST /pistas(.:format)
  def create
    if current_usuario.admin?
      pista = Pista.new(pista_params)
    else
      pista = current_usuario.pistas.build(pista_params)
    end
    
    if pista.save
      render json: pista, 
        :except => [:id, :created_at,  :responsavel_id, :foto_file_name, :foto_content_type, :foto_file_size, :foto_updated_at],
        :methods => [:foto_url, :responsavel_uuid],
        :include => { 
          :local => {:except => [:id, :created_at, :updated_at, :localizavel_id, :localizavel_type]},
          :esportes => {:except => [:created_at, :updated_at]},
          :horario => {:except => [:id, :created_at, :updated_at, :funcionamento_id, :funcionamento_type]}
        }
    else
      render json: pista.errors
    end
  end
  
  # PATCH/PUT /pistas/:id
  def update
    if current_usuario.admin?
      pista = Pista.find_by_uuid!(params[:id])
    else
      pista = current_usuario.pistas.find_by_uuid!(params[:id])
    end
    
    if pista.update(pista_params)
      render json: pista, 
        :except => [:id, :created_at, :responsavel_id, :foto_file_name, :foto_content_type, :foto_file_size, :foto_updated_at],
        :methods => [:foto_url, :responsavel_uuid],
        :include => { 
          :local => {:except => [:id, :created_at, :updated_at, :localizavel_id, :localizavel_type]},
          :esportes => {:except => [:created_at, :updated_at]},
          :horario => {:except => [:id, :created_at, :updated_at, :funcionamento_id, :funcionamento_type]}
        }
    else
      render json: pista.errors
    end
  end

  private
  
  def pista_params
    params.require(:pista).permit(:nome, :telefone, :email, :website, :facebook, :foto, :fundo, :descricao, :updated_at,
              esporte_ids: [],
              locais_attributes: [:id, :latitude, :longitude, :logradouro, :numero, :complemento, :bairro, :cidade, :estado, :cep, :pais], 
              horario_attributes: [:id, :seg, :ter, :qua, :qui, :sex, :sab, :dom, :inicio, :fim, :detalhes])
  end

end

