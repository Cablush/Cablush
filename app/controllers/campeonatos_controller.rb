class CampeonatosController < ApplicationController

def index
	@campeonatos = Campeonato.all
    #@campeonatos = @campeonatos.eventos_by_estado(params[:estado]) if params[:estado].present?
    #@campeonatos = @campeonatos.eventos_by_esporte_categoria(params[:esporte]) if params[:esporte].present?

    @clear = params[:filter] && params[:page].blank? || nil
    @title = I18n.t 'views.campeonatos.title'

    if @campeonatos.empty?
      flash.now[:alert] = I18n.t 'views.campeonatos.not_found'
    end

    respond_to do |format|
      format.html { @campeonatos }
      #format.js { @campeonatos }
      format.json { render json: @campeonatos.to_json }
    end
end

def cadastros

end

end
