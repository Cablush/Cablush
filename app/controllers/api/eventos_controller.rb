class Api::EventosController < Api::ApiController

  acts_as_token_authentication_handler_for Usuario, only: [:mine, :create, :update, :upload]
  
  impressionist actions: [:index]

  # GET /api/eventos
  def index
    eventos = Evento.actives_ordered.find_like_name(params['nome'])
    eventos = eventos.find_by_estado(params['estado'])
    eventos = eventos.find_by_esporte_categoria(params['esporte'])
    
    render_json_resource eventos
  end
  
  # GET /api/eventos/:uuid
  def show
    evento = Evento.find_by_uuid!(params[:uuid])
    impressionist(evento)
    
    render_json_success nil, 200
  end
  
  # GET /api/eventos/mine
  def mine
    eventos = Evento.actives_ordered.where(responsavel_id: current_usuario.id)
    
    render_json_resource eventos
  end
  
  # POST /api/eventos(.:format)
  def create
    evento = build_evento
    evento.responsavel = current_usuario
    
    if evento.save
      render_json_success evento, 200
    else
      render_json_error evento.errors, 500
    end
  end
  
  # PATCH/PUT /api/eventos/:uuid
  def update
    evento = Evento.find_by_uuid_and_responsavel_id(params[:uuid], current_usuario.id)
    
    unless evento.nil?
      evento = build_evento(evento)
      if evento.save
        render_json_success evento, 200
      else
        render_json_error evento.errors, 500
      end
    else
      render_json_error 'Evento not found', 404
    end
  end
  
  # POST /api/eventos/:uuid/upload
  def upload
    evento = Evento.find_by_uuid_and_responsavel_id(params[:uuid], current_usuario.id)
    
    unless evento.nil?
      if evento.update_attribute(:flyer, params[:flyer])
        render_json_success evento, 200
      else
        render_json_error evento.errors, 500
      end
    else
      render_json_error 'Evento not found', 404
    end
  end

  private
  
  def build_evento(evento = nil)
    # get the permitted parameters
    evento_attributes = params.permit(:nome, :descricao, :data, :hora, :website, :facebook, :responsavel_uuid, :uuid, :data_fim,
        esportes: [:id],
        local: [:latitude, :longitude, :logradouro, :numero, :complemento, :bairro, :cidade, :estado, :cep, :pais]
      )
    
    # extract nested objects
    responsavel_uuid = evento_attributes.delete("responsavel_uuid")
    esporte_attributes = evento_attributes.delete("esportes")
    local_attributes = evento_attributes.delete("local")
    
    # create a new object or update if it exists
    if evento.nil?
      evento = Evento.new(evento_attributes)
    else
      evento.assign_attributes(evento_attributes)
    end
    evento.esporte_ids = esporte_attributes.map{|e| e["id"]}
    evento.local = Local.new(local_attributes)
    return evento
  end
  
end
