class EventosController < ApplicationController
  impressionist actions: [:index]

  # GET /eventos(.:format)
  def index
    load_eventos

    @title = I18n.t 'views.eventos.title'

    flash.now[:alert] = I18n.t 'views.eventos.not_found' if @locais.empty?

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @locais.to_json }
    end
  end

  # GET /eventos/:uuid(.:format)
  def show
    load_eventos unless request.xhr?

    @evento = Evento.find_by_uuid!(params[:uuid])

    impressionist(@evento)

    @title = @evento.nome

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @evento.to_json }
    end
  end

  private

  def load_eventos
    @locais = Local.eventos.paginate(page: params[:page], per_page: 9)
    @locais = @locais.eventos_by_estado(params[:estado]) if params[:estado].present?
    @locais = @locais.eventos_by_esporte_categoria(params[:esporte]) if params[:esporte].present?

    @clear = params[:filter] && params[:page].blank? || nil
  end
end
