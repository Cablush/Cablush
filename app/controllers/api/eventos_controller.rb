class Api::EventosController < Api::ApiController

  before_action :authenticate_usuario!, only: [:mine, :create, :update, :upload]

  # GET /eventos
  def index
    eventos = Evento.visible.find_like_name(params['nome'])
    eventos = eventos.find_by_estado(params['estado'])
    eventos = eventos.find_by_esporte_categoria(params['esporte'])
    
    render_eventos eventos
  end
  
  # GET /eventos/mine
  def mine
    eventos = Evento.visible.where(responsavel_id: current_usuario.id)
    
    render_eventos eventos
  end
  
  # POST /eventos(.:format)
  def create
    evento = build_evento
    evento.responsavel = current_usuario
    
    if evento.save
      render_success evento
    else
      render_error evento
    end
  end
  
  # PATCH/PUT /eventos/:uuid
  def update
    evento = Evento.find_by_uuid_and_responsavel_id(params[:uuid], current_usuario.id)
    evento = build_evento(evento)
    
    if evento.save
      render_success evento
    else
      render_error evento
    end
  end
  
  # POST /eventos/:uuid/upload
  def upload
    evento = Evento.find_by_uuid_and_responsavel_id(params[:uuid], current_usuario.id)
    
    if evento.update(params[:flyer])
      render_success evento
    else
      render_error evento
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
    if (evento.nil?)
      evento = Evento.new(evento_attributes)
    else
      evento.assign_attributes(evento_attributes)
    end
    evento.esporte_ids = esporte_attributes.map{|e| e["id"]}
    evento.local = Local.new(local_attributes)
    return evento
  end
  
  def render_eventos(eventos)
    render json: eventos
  end
  
  def render_success(evento)
    render json: {
        success: true,
        data: evento
      }
  end
  
  def render_error(evento)
    render json: {
        success: false,
        errors: evento.errors
      }, status: 500
  end

end
