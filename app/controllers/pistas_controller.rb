class PistasController < ApplicationController
  
  include LocalAutocompletes, EsporteAutocompletes
  
  before_action :authenticate_usuario!, :except => :search
  #before_action :lojista_at_least, :except => :show
  
  # GET /pistas(.:format)
  def search
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

  # GET /pistas(.:format)
  def index
    if current_usuario.admin?
      @pistas = Pista.all
    else
      @pistas = current_usuario.pistas
    end
  end
  
  # GET /pistas/new(.:format)
  def new
    @pista = Pista.new
    @pista.build_local
    @pista.build_horario
  end

  # POST /pistas(.:format)
  def create
    update_esporte_ids(params[:loja])
    
    @pista = current_usuario.pistas.build(pista_params)
    
    if @pista.save
      redirect_to pistas_path
    else
      render 'new'
    end
  end
  
  # GET /pistas/:id(.:format)
  def show
    @pista = Pista.find_by_uuid!(params[:id])
  end

  # GET /pistas/:id/edit(.:format)
  def edit
    if current_usuario.admin?
      @pista = Pista.find_by_uuid!(params[:id])
    else
      @pista = current_usuario.pistas.find_by_uuid!(params[:id])
    end
    
    if @pista.local.blank?
      @pista.build_local
    end
    
    if @pista.horario.blank?
      @pista.build_horario
    end
  end

  # PATCH/PUT /pistas/:id(.:format)
  def update
    if current_usuario.admin?
      @pista = Pista.find_by_uuid!(params[:id])
    else
      @pista = current_usuario.pistas.find_by_uuid!(params[:id])
    end

    update_esporte_ids(params[:loja])
    
    if @pista.update(pista_params)
      redirect_to pistas_path
    else
      render 'edit'
    end
  end
  
  # DELETE /pistas/:id(.:format)
  def destroy
    if current_usuario.admin?
      @pista = Pista.find_by_uuid!(params[:id])
    else
      @pista = current_usuario.pistas.find_by_uuid!(params[:id])
    end
    
    @pista.destroy

    redirect_to pistas_path
  end
  
  private
  
  def pista_params
    params.require(:pista)
          .permit(:nome, :descricao, :website, :facebook, :foto, 
              esporte_ids: [],
              local_attributes: [:id, :latitude, :longitude, :logradouro, :numero, :complemento, :bairro, :cidade, :estado, :cep, :pais], 
              horario_attributes: [:id, :seg, :ter, :qua, :qui, :sex, :sab, :dom, :inicio, :fim, :detalhes])
  end
  
end
