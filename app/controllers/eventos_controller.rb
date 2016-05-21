class EventosController < ApplicationController

  impressionist actions: [:index]

  # GET /eventos(.:format)
  def index

    load_eventos

    @title = "Veja o que está acontecendo e participe!"

    if @locais.empty?
      flash.now[:alert] = 'Nenhum evento encontrado! Cadastre-se no Cablush e divulge os eventos da sua região!'
    end

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @locais.to_json }
    end
  end

  # GET /eventos/:uuid(.:format)
  def show

    unless request.xhr?
      load_eventos
    end

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
    @locais = Local.eventos.paginate(:page => params[:page], :per_page => 9)
    @locais = @locais.eventos_by_estado(params[:estado]) if params[:estado].present?
    @locais = @locais.eventos_by_esporte_categoria(params[:esporte]) if params[:esporte].present?

    @clear = params[:filter] && params[:page].blank? || nil
  end

end
