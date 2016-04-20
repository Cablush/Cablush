class Api::PistasController < Api::ApiController
  
  acts_as_token_authentication_handler_for Usuario, only: [:mine, :create, :update, :upload]
  
  impressionist actions: [:index]
  
  # GET /api/pistas
  def index
    pistas = Pista.find_like_name(params['nome'])
    pistas = pistas.find_by_estado(params['estado'])
    pistas = pistas.find_by_esporte_categoria(params['esporte'])
    
    render_json_resource pistas
  end
  
  # GET /api/pistas/:uuid
  def show
    pista = Pista.find_by_uuid!(params[:uuid])
    impressionist(pista)
    
    render_json_success nil, 200
  end
  
  # GET /api/pistas/mine
  def mine
    pistas = Pista.where(responsavel_id: current_usuario.id)
    
    render_json_resource pistas
  end

  # POST /api/pistas(.:format)
  def create
    pista = build_pista
    pista.responsavel = current_usuario
    
    if pista.save
      render_json_success pista, 200
    else
      render_json_error pista.errors, 500
    end
  end
  
  # PATCH/PUT /api/pistas/:uuid
  def update
    pista = Pista.find_by_uuid_and_responsavel_id(params[:uuid], current_usuario.id)
    pista = build_pista(pista)
    
    if pista.save pista
      render_json_success pista, 200
    else
      render_json_error pista.errors, 500
    end
  end
  
  # POST /api/pistas/:uuid/upload
  def upload
    pista = Pista.find_by_uuid_and_responsavel_id(params[:uuid], current_usuario.id)
    
    unless pista.nil?
      if pista.update_attribute(:foto, params[:foto])
        render_json_success pista, 200
      else
        render_json_error pista.errors, 500
      end
    else
      render_json_error 'Pista not found', 404
    end
  end

  private
  
  def build_pista(pista = nil)
    # get the permitted parameters
    pista_attributes = params.permit(:nome, :descricao, :website, :facebook, :video, :responsavel_uuid, :uuid,
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
    if pista.nil?
      pista = Pista.new(pista_attributes)
    else
      pista.assign_attributes(pista_attributes)
    end
    pista.esporte_ids = esporte_attributes.map{|e| e["id"]}
    pista.horario = Horario.new(horario_attributes)
    pista.local = Local.new(local_attributes)
    return pista
  end
  
end