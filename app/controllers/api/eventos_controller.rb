class Api::EventosController < Api::ApiController

  before_action :authenticate_usuario!, only: [:mine, :create, :update]

  # GET /eventos
  def index
    eventos = Evento.visible.find_like_name(params['nome'])
    eventos = eventos.find_by_estado(params['estado'])
    eventos = eventos.find_by_esporte_categoria(params['esporte'])
    
    render json: eventos, 
        :except => [:id, :created_at, :responsavel_id, :flyer_file_name, :flyer_content_type, :flyer_file_size, :flyer_updated_at],
        :methods => [:flyer_url],
        :include => {
          :local => {:except => [:id, :created_at, :updated_at, :localizavel_id, :localizavel_type]},
          :esportes => {:except => [:created_at, :updated_at]}
        }
  end
  
  # GET /eventos/mine
  def mine
    eventos = Evento.visible.where(responsavel_id: current_usuario.id)
    
    render json: eventos, 
        :except => [:id, :created_at, :responsavel_id, :flyer_file_name, :flyer_content_type, :flyer_file_size, :flyer_updated_at],
        :methods => [:flyer_url, :responsavel_uuid],
        :include => {
          :local => {:except => [:id, :created_at, :updated_at, :localizavel_id, :localizavel_type]},
          :esportes => {:except => [:created_at, :updated_at]}
        }
  end
  
  # POST /eventos(.:format)
  def create
    if current_usuario.admin?
      evento = Evento.new(evento_params)
    else
      evento = current_usuario.eventos.build(evento_params)
    end
    
    if evento.save
      render json: evento, 
        :except => [:id, :created_at, :responsavel_id, :flyer_file_name, :flyer_content_type, :flyer_file_size, :flyer_updated_at],
        :methods => [:flyer_url, :responsavel_uuid],
        :include => {
          :local => {:except => [:id, :created_at, :updated_at, :localizavel_id, :localizavel_type]},
          :esportes => {:except => [:created_at, :updated_at]}
        }
    else
      render json: evento.errors
    end
  end
  
  # PATCH/PUT /eventos/:uuid
  def update
    if current_usuario.admin?
      evento = Evento.find_by_uuid!(params[:uuid])
    else
      evento = current_usuario.eventos.find_by_uuid!(params[:uuid])
    end
    
    if evento.update(evento_params)
      render json: evento, 
        :except => [:id, :created_at, :responsavel_id, :flyer_file_name, :flyer_content_type, :flyer_file_size, :flyer_updated_at],
        :methods => [:flyer_url, :responsavel_uuid],
        :include => {
          :local => {:except => [:id, :created_at, :updated_at, :localizavel_id, :localizavel_type]},
          :esportes => {:except => [:created_at, :updated_at]}
        }
    else
      render json: evento.errors
    end
  end

  private
  
  def evento_params
    params.require(:evento).permit(:uuid, :nome, :telefone, :email, :website, :facebook, :flyer, :fundo, :descricao, :updated_at,
              esporte_ids: [],
              local_attributes: [:latitude, :longitude, :logradouro, :numero, :complemento, :bairro, :cidade, :estado, :cep, :pais])
  end

end
