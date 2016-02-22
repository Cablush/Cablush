class Cadastros::EventosController < ApplicationController
  
  include LocalAutocompletes, EsporteAutocompletes
  
  before_action :authenticate_usuario!
  #before_action :lojista_at_least, :except => :show
  
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
  
  # GET /eventos/:uuid(.:format)
  def show
    @loja = Evento.find_by_uuid!(params[:uuid])
  end
  
  # GET /eventos/:uuid/edit(.:format)
  def edit
    if current_usuario.admin?
      @evento = Evento.find_by_uuid!(params[:uuid])
    else
      @evento = current_usuario.eventos.find_by_uuid!(params[:uuid])
    end
    
    if @evento.local.blank?
      @evento.build_local
    end
  end

  # PATCH/PUT /eventos/:uuid(.:format)
  def update
    if current_usuario.admin?
      @evento = Evento.find_by_uuid!(params[:uuid])
    else
      @evento = current_usuario.eventos.find_by_uuid!(params[:uuid])
    end

    update_esporte_ids(params[:loja])
    
    if @evento.update(evento_params)
      redirect_to eventos_path
    else
      render 'edit'
    end
  end
  
  # DELETE /eventos/:uuid(.:format)
  def destroy
    if current_usuario.admin?
      @evento = Evento.find_by_uuid!(params[:uuid])
    else
      @evento = current_usuario.eventos.find_by_uuid!(params[:uuid])
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
