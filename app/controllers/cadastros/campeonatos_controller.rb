class Cadastros::CampeonatosController < ApplicationController
  
  before_action :authenticate_usuario!
  #before_action :lojista_at_least, :except => :show
  
  # GET /campeonatos(.:format)
  def index
    if current_usuario.admin?
      @campeonatos = Campeonato.all.order('data_inicio DESC')
    else
      @campeonatos = Campeonato.all.order('data_inicio DESC')
    end
    @title = "Você já cadastrou " + @campeonatos.length.to_s + " campeonatos."
  end
  
  # GET /campeonatos/new(.:format)
  def new
    @campeonato = Campeonato.new
    #@campeonato.build_local
    @title = "Entre com os dados do novo campeonato."
  end

  # POST /campeonatos(.:format)
  def create
    #update_esporte_ids(params[:loja])
    
    @campeonato = Campeonato.new(campeonato_params) #current_usuario.campeonatos.build(campeonato_params)
    
    if @campeonato.save
      redirect_to campeonatos_path
    else
      render 'new'
    end
  end
  
  # GET /campeonatos/:uuid(.:format)
  def show
    @loja = Campeonato.find_by_uuid!(params[:uuid])
  end
  
  # GET /campeonatos/:uuid/edit(.:format)
  def edit
    if current_usuario.admin?
      @campeonato = Campeonato.find_by_uuid!(params[:uuid])
    else
      @campeonato = current_usuario.campeonatos.find_by_uuid!(params[:uuid])
    end
    
    if @campeonato.local.blank?
      @campeonato.build_local
    end
    @title = ("Você esta editando o campeonato<br/> \"" + @campeonato.nome + "\"").html_safe;
  end

  # PATCH/PUT /campeonatos/:uuid(.:format)
  def update
    if current_usuario.admin?
      @campeonato = Campeonato.find_by_uuid!(params[:uuid])
    else
      @campeonato = current_usuario.campeonatos.find_by_uuid!(params[:uuid])
    end

    update_esporte_ids(params[:loja])
    
    if @campeonato.update(evento_params)
      redirect_to campeonatos_path
    else
      render 'edit'
    end
  end
  
  # DELETE /campeonatos/:uuid(.:format)
  def destroy
    if current_usuario.admin?
      @campeonato = Campeonato.find_by_uuid!(params[:uuid])
    else
      @campeonato = current_usuario.campeonatos.find_by_uuid!(params[:uuid])
    end
    
    @campeonato.destroy
    redirect_to campeonatos_path
  end
  
  private
  
  def campeonato_params
    params.require(:campeonato)
          .permit(:nome, :descricao ,:data_inicio, :hora, :data_fim ,
            etapas_attributes: [:nome, :qtdProvas, :numCompetidoresProva])
  end

end
