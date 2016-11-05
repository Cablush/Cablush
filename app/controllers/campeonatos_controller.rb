class CampeonatosController < ApplicationController
  impressionist actions: [:index]

  # GET /campeonatos(.:format)
  def index
    load_campeonatos

    @title = I18n.t 'views.campeonatos.title'

    flash.now[:alert] = I18n.t 'views.campeonatos.not_found' if @campeonatos.empty?

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @campeonatos.to_json }
    end
  end

  # GET /campeonatos/:uuid(.:format)
  def show
    load_campeonatos unless request.xhr?

    @campeonato = Campeonato.find_by_uuid!(params[:uuid])

    impressionist(@campeonato)

    @title = @campeonato.nome

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @campeonato.to_json }
    end
  end

  private

  def load_campeonatos
    @locais = Local.campeonatos.paginate(page: params[:page], per_page: 9)
    @locais = @locais.campeonatos_by_estado(params[:estado]) if params[:estado].present?
    @locais = @locais.campeonatos_by_esporte_categoria(params[:esporte]) if params[:esporte].present?

    @clear = params[:filter] && params[:page].blank? || nil
  end
end
