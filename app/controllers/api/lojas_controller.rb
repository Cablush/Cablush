class Api::LojasController < Api::ApiController
	
  # GET /lojas
  def index
    @lojas = Loja.find_like_name(loja_params['nome'])
    @lojas = @lojas.find_by_estado(loja_params['estado'])
    @lojas = @lojas.find_by_esporte_id(loja_params['esporte'])
    
    respond_to do |format|
      format.json { render json: @lojas, 
        :except => [:id, :created_at, :updated_at, :responsavel_id, :logo_updated_at],
        :include => { :locais => {:except => [:id, :created_at, :updated_at, :localizavel_id]}}
      }
		end
  end
  
  private
  
  def loja_params
    params.permit(:nome, :estado, :esporte)
  end
  
end
