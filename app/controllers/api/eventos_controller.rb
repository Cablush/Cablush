class Api::EventosController < Api::ApiController

  before_action :authenticate_usuario!, only: [:mine, :create, :update]

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
    if current_usuario.admin?
      evento = Evento.find_by_uuid!(params[:uuid])
    else
      evento = current_usuario.eventos.find_by_uuid!(params[:uuid])
    end
    
    if evento.update(build_evento)
      render_success evento
    else
      render_error evento
    end
  end

  private
  
  def build_evento
    # get the permitted parameters
    evento_attributes = params.permit(:uuid, :nome, :telefone, :email, :website, :facebook, :flyer, :fundo, :descricao, :updated_at,
        esportes: [:id],
        local: [:latitude, :longitude, :logradouro, :numero, :complemento, :bairro, :cidade, :estado, :cep, :pais]
      )
    
    # extract nested objects
    esporte_attributes = evento_attributes.delete("esportes")
    local_attributes = evento_attributes.delete("locais")
    
    # create the object
    evento = Evento.new(evento_attributes)
    evento.esporte_ids = esporte_attributes.map{|e| e["id"]}
    evento.locais = Local.new(local_attributes)
    return evento
  end
  
  def render_eventos(eventos)
    render json: eventos, 
      :except => [:id, :created_at, :responsavel_id, :flyer_file_name, :flyer_content_type, :flyer_file_size, :flyer_updated_at],
      :methods => [:flyer_url, :responsavel_uuid],
      :include => {
        :local => {:except => [:id, :created_at, :updated_at, :localizavel_id, :localizavel_type]},
        :esportes => {:except => [:created_at, :updated_at]}
      }
  end
  
  def render_success(evento)
    render json: {
        success: true,
        data: evento, 
          :except => [:id, :created_at, :responsavel_id, :flyer_file_name, :flyer_content_type, :flyer_file_size, :flyer_updated_at],
          :methods => [:flyer_url, :responsavel_uuid],
          :include => {
            :local => {:except => [:id, :created_at, :updated_at, :localizavel_id, :localizavel_type]},
            :esportes => {:except => [:created_at, :updated_at]}
          }
      }
  end
  
  def render_error(evento)
    render json: {
        success: false,
        errors: evento.errors
      }, status: 500
  end

end
