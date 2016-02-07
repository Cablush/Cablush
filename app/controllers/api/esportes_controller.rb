class Api::EsportesController < Api::ApiController
	
  # GET /esportes
  def index
    esportes = Esporte.all
    
    render json: esportes, 
      :except => [:created_at, :updated_at]
  end
  
  private
  
  def evento_params
    params.permit(:nome, :categoria)
  end

end
