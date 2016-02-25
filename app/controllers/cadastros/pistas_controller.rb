class Cadastros::PistasController < ApplicationController
  
  include LocalAutocompletes, EsporteAutocompletes
  
  before_action :authenticate_usuario!
  #before_action :lojista_at_least, :except => :show
  
  # GET /pistas(.:format)
  def index
    if current_usuario.admin?
      @pistas = Pista.all
    else
      @pistas = current_usuario.pistas
    end
    @title = "Você já cadastrou " + @pistas.length.to_s + " pistas."
  end
  
  # GET /pistas/new(.:format)
  def new
    @pista = Pista.new
    @pista.build_local
    @pista.build_horario
    @title = "Entre com os dados da nova pista."
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
  
  # GET /pistas/:uuid(.:format)
  def show
    @loja = Pista.find_by_uuid!(params[:uuid])
  end
  
  # GET /pistas/:uuid/edit(.:format)
  def edit
    if current_usuario.admin?
      @pista = Pista.find_by_uuid!(params[:uuid])
    else
      @pista = current_usuario.pistas.find_by_uuid!(params[:uuid])
    end
    
    if @pista.local.blank?
      @pista.build_local
    end
    
    if @pista.horario.blank?
      @pista.build_horario
    end
    @title = ("Você esta editando a pista<br/> \"" + @pista.nome + "\"").html_safe;
  end

  # PATCH/PUT /pistas/:uuid(.:format)
  def update
    if current_usuario.admin?
      @pista = Pista.find_by_uuid!(params[:uuid])
    else
      @pista = current_usuario.pistas.find_by_uuid!(params[:uuid])
    end

    update_esporte_ids(params[:loja])
    
    if @pista.update(pista_params)
      redirect_to pistas_path
    else
      render 'edit'
    end
  end
  
  # DELETE /pistas/:uuid(.:format)
  def destroy
    if current_usuario.admin?
      @pista = Pista.find_by_uuid!(params[:uuid])
    else
      @pista = current_usuario.pistas.find_by_uuid!(params[:uuid])
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
