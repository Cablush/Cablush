class PistasController < ApplicationController

  impressionist actions: [:index]

  # GET /pistas(.:format)
  def index

    load_pistas

    @title = "Onde praticar?"

    if @locais.empty?
      flash.now[:alert] = 'Nenhuma pista encontrada! Cadastre-se no Cablush e divulge as pistas da sua cidade!'
    end

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @locais.to_json }
    end
  end

  # GET /pistas/:uuid(.:format)
  def show

    unless request.xhr?
      load_pistas
    end

    @pista = Pista.find_by_uuid!(params[:uuid])

    impressionist(@pista)

    @title = @pista.nome

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @pista.to_json }
    end
  end

  private

  def load_pistas
    @locais = Local.pistas.paginate(:page => params[:page], :per_page => 9)
    @locais = @locais.pistas_by_estado(params[:estado]) if params[:estado].present?
    @locais = @locais.pistas_by_esporte_categoria(params[:esporte]) if params[:esporte].present?

    @clear = params[:filter] && params[:page].blank? || nil
  end

end
