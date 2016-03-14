class EventosController < ApplicationController
  
  # GET /eventos(.:format)
  def index
    @locais = Local.eventos.paginate(:page => params[:page], :per_page => 9)
    @locais = @locais.eventos_by_estado(params[:estado]) if params[:estado].present?
    @locais = @locais.eventos_by_esporte_categoria(params[:esporte]) if params[:esporte].present?
    
    @clear = params[:filter] && params[:page].blank? || nil
    @title = "Veja o que está acontecendo e participe!"
    
    if @locais.empty?
      flash.now[:alert] = 'Nenhum evento encontrado! Cadastre-se no Cablush e divulge os eventos da sua região!'
    end
    
    respond_to do |format|
      format.html { @locais }
      format.js { @locais }
      format.json { render json: @locais.to_json }
    end
  end
  
  # GET /eventos/:uuid(.:format)
  def show
    @evento = Evento.find_by_uuid!(params[:uuid])
    
    @title = @evento.nome
    
    respond_to do |format|
      format.html { render layout: 'modal' }
      format.js { @evento }
      format.json { render json: @evento.to_json }
    end
  end

end
