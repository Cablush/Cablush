class Api::PistasController < Api::ApiController
  
  before_action :authenticate_usuario!, only: [:mine, :create, :update]
  
  # GET /pistas
  def index
    pistas = Pista.find_like_name(params['nome'])
    pistas = pistas.find_by_estado(params['estado'])
    pistas = pistas.find_by_esporte_categoria(params['esporte'])
    
    render_pistas pistas
  end
  
  # GET /pistas/mine
  def mine
    pistas = Pista.where(responsavel_id: current_usuario.id)
    
    render_pistas pistas
  end

  # POST /pistas(.:format)
  def create
    pista = build_pista
    pista.responsavel = current_usuario
    
    if pista.save
      render_success pista
    else
      render_error pista
    end
  end
  
  # PATCH/PUT /pistas/:uuid
  def update
    if current_usuario.admin?
      pista = Pista.find_by_uuid!(params[:uuid])
    else
      pista = current_usuario.pistas.find_by_uuid!(params[:uuid])
    end
    
    if pista.update(build_pista)
      render_success pista
    else
      render_error pista
    end
  end

  private
  
  def build_pista
    # get the permitted parameters
    pista_attributes = params.permit(:uuid, :nome, :telefone, :email, :website, :facebook, :foto, :fundo, :descricao, :updated_at,
        esportes: [:id],
        horario: [:seg, :ter, :qua, :qui, :sex, :sab, :dom, :inicio, :fim, :detalhes],
        local: [:latitude, :longitude, :logradouro, :numero, :complemento, :bairro, :cidade, :estado, :cep, :pais]
      )
    
    # extract nested objects
    esporte_attributes = pista_attributes.delete("esportes")
    horario_attributes = pista_attributes.delete("horario")
    local_attributes = pista_attributes.delete("locais")
    
    # create the object
    pista = Pista.new(pista_attributes)
    pista.esporte_ids = esporte_attributes.map{|e| e["id"]}
    pista.horario = Horario.new(horario_attributes)
    pista.locais = Local.new(local_attributes)
    return pista
  end
  
  def render_pistas(pistas)
    render json: pistas, 
      :except => [:id, :created_at, :responsavel_id, :foto_file_name, :foto_content_type, :foto_file_size, :foto_updated_at],
      :methods => [:foto_url, :responsavel_uuid],
      :include => { 
        :local => {:except => [:id, :created_at, :updated_at, :localizavel_id, :localizavel_type]},
        :esportes => {:except => [:created_at, :updated_at]},
        :horario => {:except => [:id, :created_at, :updated_at, :funcionamento_id, :funcionamento_type]}
      }
  end
  
  def render_success(pista)
    render json: {
        success: true,
        data: pista, 
          :except => [:id, :created_at, :responsavel_id, :foto_file_name, :foto_content_type, :foto_file_size, :foto_updated_at],
          :methods => [:foto_url, :responsavel_uuid],
          :include => { 
            :local => {:except => [:id, :created_at, :updated_at, :localizavel_id, :localizavel_type]},
            :esportes => {:except => [:created_at, :updated_at]},
            :horario => {:except => [:id, :created_at, :updated_at, :funcionamento_id, :funcionamento_type]}
          }
      }
  end
  
  def render_error(pista)
    render json: {
        success: false,
        errors: pista.errors
      }, status: 500
  end

end