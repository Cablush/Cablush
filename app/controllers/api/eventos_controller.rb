class Api::EventosController < Api::ApiController
	
  # GET /eventos
  def index
    eventos = Evento.visible.find_like_name(params['nome'])
    eventos = eventos.find_by_estado(params['estado'])
    eventos = eventos.find_by_esporte_categoria(params['esporte'])
    
    render json: eventos, 
        :except => [:id, :created_at, :updated_at, :responsavel_id, :logo_updated_at],
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
        :except => [:id, :created_at, :updated_at, :responsavel_id, :logo_updated_at],
        :include => {
          :local => {:except => [:id, :created_at, :updated_at, :localizavel_id, :localizavel_type]},
          :esportes => {:except => [:created_at, :updated_at]}
        }
    else
      render json: evento.errors
    end
  end
  
  # GET /eventos/:id
  def show
    evento = Evento.find_by_uuid!(params[:id])
    render json: evento, 
        :except => [:id, :created_at, :updated_at, :responsavel_id, :logo_updated_at],
        :include => {
          :local => {:except => [:id, :created_at, :updated_at, :localizavel_id, :localizavel_type]},
          :esportes => {:except => [:created_at, :updated_at]}
        }
  end
  
  # PATCH/PUT /eventos/:id
  def update
    if current_usuario.admin?
      evento = Evento.find_by_uuid!(params[:id])
    else
      evento = current_usuario.eventos.find_by_uuid!(params[:id])
    end
    
    if evento.update(evento_params)
      render json: evento, 
        :except => [:id, :created_at, :updated_at, :responsavel_id, :logo_updated_at],
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
    params.require(:evento).permit(:nome, :telefone, :email, :website, :facebook, :logo, :fundo, :descricao, 
              esporte_ids: [],
              local_attributes: [:id, :latitude, :longitude, :logradouro, :numero, :complemento, :bairro, :cidade, :estado, :cep, :pais])
  end

end
