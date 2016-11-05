class PistasController < ApplicationController
  impressionist actions: [:index]

  # GET /pistas(.:format)
  def index
    load_pistas

    @title = I18n.t 'views.pistas.title'

    flash.now[:alert] = I18n.t 'views.pistas.not_found' if @locais.empty?

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @locais.to_json }
    end
  end

  # GET /pistas/:uuid(.:format)
  def show
    load_pistas unless request.xhr?

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
    @locais = Local.pistas.paginate(page: params[:page], per_page: 9)
    @locais = @locais.pistas_by_estado(params[:estado]) if params[:estado].present?
    @locais = @locais.pistas_by_esporte_categoria(params[:esporte]) if params[:esporte].present?

    @clear = params[:filter] && params[:page].blank? || nil
  end
end
