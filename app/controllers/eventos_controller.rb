class EventosController < ApplicationController
  
  include LocalAutocompletes, EsporteAutocompletes
  
  before_action :authenticate_usuario!, :except => :search
  #before_action :lojista_at_least, :except => :show
  
  # GET /eventos(.:format)
  def search
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
  
  # GET /eventos(.:format)
  def index
    if current_usuario.admin?
      @eventos = Evento.all
    else
      @eventos = current_usuario.eventos
    end
  end
  
  # GET /eventos/new(.:format)
  def new
    @evento = Evento.new
    @evento.build_local
  end

  # POST /eventos(.:format)
  def create
    update_esporte_ids(params[:loja])
    
    @evento = current_usuario.eventos.build(evento_params)
    
    if @evento.save
      redirect_to eventos_path
    else
      render 'new'
    end
  end
  
  # GET /eventos/:id(.:format)
  def show
    @evento = Evento.find_by_uuid!(params[:id])
  end

  # GET /eventos/:id/edit(.:format)
  def edit
    if current_usuario.admin?
      @evento = Evento.find_by_uuid!(params[:id])
    else
      @evento = current_usuario.eventos.find_by_uuid!(params[:id])
    end
    
    if @evento.local.blank?
      @evento.build_local
    end
  end

  # PATCH/PUT /eventos/:id(.:format)
  def update
    if current_usuario.admin?
      @evento = Evento.find_by_uuid!(params[:id])
    else
      @evento = current_usuario.eventos.find_by_uuid!(params[:id])
    end

    update_esporte_ids(params[:loja])
    
    if @evento.update(evento_params)
      redirect_to eventos_path
    else
      render 'edit'
    end
  end
  
  # DELETE /eventos/:id(.:format)
  def destroy
    if current_usuario.admin?
      @evento = Evento.find_by_uuid!(params[:id])
    else
      @evento = current_usuario.eventos.find_by_uuid!(params[:id])
    end
    
    @evento.destroy

    redirect_to eventos_path
  end
  
  private
  
  def evento_params
    params.require(:evento)
          .permit(:nome, :descricao, :data, :hora, :data_fim, :website, :facebook, :flyer, 
              esporte_ids: [],
              local_attributes: [:id, :latitude, :longitude, :logradouro, :numero, :complemento, :bairro, :cidade, :estado, :cep, :pais])
  end

end
