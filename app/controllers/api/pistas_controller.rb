class Api::PistasController < Api::ApiController
  
  before_action :authenticate_usuario!, only: [:mine, :create, :update, :upload]
  
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
    pista = Pista.find_by_uuid_and_responsavel_id(params[:uuid], current_usuario.id)
    pista = build_pista(pista)
    
    if pista.save pista
      render_success pista
    else
      render_error pista
    end
  end
  
  # POST /pistas/:uuid/upload
  def upload
    pista = Pista.find_by_uuid_and_responsavel_id(params[:uuid], current_usuario.id)
    
    if pista.update(params[:foto])
      render_success pista
    else
      render_error pista
    end
  end

  private
  
  def build_pista(*pista)
    # get the permitted parameters
    pista_attributes = params.permit(:nome, :descricao, :website, :facebook, :responsavel_uuid, :uuid,
        esportes: [:id],
        horario: [:inicio, :fim, :seg, :ter, :qua, :qui, :sex, :sab, :dom, :detalhes],
        local: [:latitude, :longitude, :logradouro, :numero, :complemento, :bairro, :cidade, :estado, :cep, :pais]
      )
    
    # extract nested objects
    responsavel_uuid = pista_attributes.delete("responsavel_uuid")
    esporte_attributes = pista_attributes.delete("esportes")
    horario_attributes = pista_attributes.delete("horario")
    local_attributes = pista_attributes.delete("local")
    
    # create a new object or update if it exists
    if (pista.nil?)
      pista = Pista.new(pista_attributes)
    else
      pista.assign_attributes(pista_attributes)
    end
    pista.esporte_ids = esporte_attributes.map{|e| e["id"]}
    pista.horario = Horario.new(horario_attributes)
    pista.local = Local.new(local_attributes)
    return pista
  end
  
  def render_pistas(pistas)
    render json: pistas
  end
  
  def render_success(pista)
    render json: {
        success: true,
        data: pista
      }
  end
  
  def render_error(pista)
    render json: {
        success: false,
        errors: pista.errors
      }, status: 500
  end

end