class Api::EsportesController < Api::ApiController
	
  # GET /esportes
  def index
    @esportes = Esporte.all
    
    respond_to do |format|
      format.json { render json: @esportes}
		end
  end
  
  private
  
  def evento_params
    params.permit(:nome, :categoria)
  end

end
