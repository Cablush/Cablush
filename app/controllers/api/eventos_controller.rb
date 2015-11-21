class Api::EventosController < Api::ApiController
	
  # GET /eventos
  def index
    @eventos = Evento.visible.find_like_name(evento_params['nome'])
    @eventos = @eventos.find_by_estado(evento_params['estado'])
    @eventos = @eventos.find_by_esporte_id(evento_params['esporte'])
    
    respond_to do |format|
      format.json { render json: @eventos, 
        :except => [:id, :created_at, :updated_at, :responsavel_id, :logo_updated_at],
        :include => { :local => {:except => [:id, :created_at, :updated_at, :localizavel_id]}}
      }
		end
  end
  
  private
  
  def evento_params
    params.permit(:nome, :estado, :esporte)
  end

end
