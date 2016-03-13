class Cadastros::LojasController < ApplicationController
  
  include LocalAutocompletes, EsporteAutocompletes
  
  before_action :authenticate_usuario!
  #before_action :lojista_at_least, :except => :show
  
  # GET /lojas(.:format)
  def index
    if current_usuario.admin?
      @lojas = Loja.all
    else
      @lojas = current_usuario.lojas
    end
    @title = "Você já cadastrou " + @lojas.length.to_s + " lojas."
  end
  
  # GET /lojas/new(.:format)
  def new
    @loja = Loja.new
    @loja.locais.build
    @loja.build_horario
    @title = "Entre com os dados da nova loja."
  end

  # POST /lojas(.:format)
  def create
    update_esporte_ids(params[:loja])
    
    @loja = current_usuario.lojas.build(loja_params)
    
    if @loja.save
      redirect_to lojas_path
    else
      render 'new'
    end
  end
  
  # GET /lojas/:uuid(.:format)
  def show
    @loja = Loja.find_by_uuid!(params[:uuid])
  end
  
  # GET /lojas/:uuid/edit(.:format)
  def edit
    if current_usuario.admin?
      @loja = Loja.find_by_uuid!(params[:uuid])
    else
      @loja = current_usuario.lojas.find_by_uuid!(params[:uuid])
    end
    
    if @loja.locais.empty?
      @loja.locais.build
    end
    
    if @loja.horario.blank?
      @loja.build_horario
    end
    @title = ("Você esta editando a loja<br/> \"" + @loja.nome + "\"").html_safe;
  end

  # PATCH/PUT /lojas/:uuid(.:format)
  def update
    if current_usuario.admin?
      @loja = Loja.find_by_uuid!(params[:uuid])
    else
      @loja = current_usuario.lojas.find_by_uuid!(params[:uuid])
    end
    
    update_esporte_ids(params[:loja])
    
    if @loja.update(loja_params)
      redirect_to lojas_path
    else
      render 'edit'
    end
  end
  
  # DELETE /lojas/:uuid(.:format)
  def destroy
    if current_usuario.admin?
      @loja = Loja.find_by_uuid!(params[:uuid])
    else
      @loja = current_usuario.lojas.find_by_uuid!(params[:uuid])
    end
    
    @loja.destroy

    redirect_to lojas_path
  end
  
  private
  
  def loja_params
    params.require(:loja).permit(:nome, :telefone, :email, :website, :facebook, :logo, :fundo, :descricao, 
              esporte_ids: [],
              locais_attributes: [:id, :latitude, :longitude, :logradouro, :numero, :complemento, :bairro, :cidade, :estado, :estado_nome, :cep, :pais], 
              horario_attributes: [:id, :seg, :ter, :qua, :qui, :sex, :sab, :dom, :inicio, :fim, :detalhes])
  end
  
end
