class Api::EsportesController < Api::ApiController
	
  # GET /api/esportes
  def index
    esportes = Esporte.all
    
    render_json_resource esportes
  end
  
  private
  
  def evento_params
    params.permit(:nome, :categoria)
  end

end
