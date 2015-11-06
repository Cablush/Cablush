class Api::PistasController < ApplicationController
  
  # GET /pistas
  def index
    @pistas = Pista.find_like_name(pista_params['nome'])
    @pistas = @pistas.find_by_estado(pista_params['estado'])
    @pistas = @pistas.find_by_esporte_id(pista_params['esporte'])
    
    respond_to do |format|
      format.json { render json: @pistas, 
        :except => [:id, :created_at, :updated_at, :responsavel_id, :logo_updated_at],
        :include => { :local => {:except => [:id, :created_at, :updated_at, :localizavel_id]}}
      }
    end
  end
  
  private
  
  def pista_params
    params.permit(:nome, :estado, :esporte)
  end
end

