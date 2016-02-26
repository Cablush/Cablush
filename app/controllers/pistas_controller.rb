class PistasController < ApplicationController
  
  include LocalAutocompletes, EsporteAutocompletes
  
  # GET /pistas(.:format)
  def index
    @locais = Local.pistas.paginate(:page => params[:page], :per_page => 9)
    @locais = @locais.pistas_by_estado(params[:estado]) if params[:estado].present?
    @locais = @locais.pistas_by_esporte_categoria(params[:esporte]) if params[:esporte].present?
    
    @clear = params[:filter] && params[:page].blank? || nil
    @title = "Onde praticar?"
    
    if @locais.empty?
      flash.now[:alert] = 'Nenhuma pista encontrada! Cadastre-se no Cablush e divulge as pistas da sua cidade!'
    end
   
    respond_to do |format|
      format.html { @locais }
      format.js { @locais }
      format.json { render json: @locais.to_json }
    end
  end

  # GET /pistas/:uuid(.:format)
  def show
    @pista = Pista.find_by_uuid!(params[:uuid])
    
    respond_to do |format|
      format.html { render layout: 'modal' }
      format.js { @pista }
      format.json { render json: @pista.to_json }
    end
  end

end
