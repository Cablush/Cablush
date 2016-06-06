class Cadastros::CampeonatosController < ApplicationController
  
  before_action :authenticate_usuario!
  #before_action :lojista_at_least, :except => :show
  
  # GET /campeonatos(.:format)
  def index
    if current_usuario.admin?
      @campeonatos = Campeonato.all.order('data_inicio DESC')
    else
      @campeonatos = current_usuario.campeonatos.order('data_inicio DESC')
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
    
    @campeonato = current_usuario.campeonatos.build(campeonato_params) #current_usuario.campeonatos.build(campeonato_params)
    if @campeonato.save
      if save_categoria(params, @campeonato.id)     
        redirect_to eventos_path  
      end
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
    
    @title = ("Você esta editando o campeonato<br/> \"" + @campeonato.nome + "\"").html_safe;
  end

  # PATCH/PUT /campeonatos/:uuid(.:format)
  def update
    if current_usuario.admin?
      @campeonato = Campeonato.find_by_uuid!(params[:uuid])
    else
      @campeonato = current_usuario.campeonatos.find_by_uuid!(params[:uuid])
    end

    #update_categoria_ids(params)
    check_categorias_deleted(params,@campeonato.id)
    if @campeonato.update(campeonato_params)
      #redirect_to campeonatos_path
    #else
      #if update_categoria_ids(params)
       # puts "update"
        redirect_to eventos_path
      #end
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
    redirect_to eventos_path
  end
  
  private
  
  def campeonato_params
    params.require(:campeonato)
          .permit(:nome, :descricao ,:data_inicio, :hora, :data_fim ,
            categorias_attributes: [:nome, :descricao, :regras ],
            etapas_attributes: [:nome, :qtdProvas, :numCompetidoresProva])
  end

  
  def save_categoria(host_params, campeonato_id)
    if params[:categorias_attibutes].present?
      params[:categorias_attibutes].each do |index, categoria_params|
        if categoria_params[:id].blank? && categoria_params[:nome].present? && categoria_params[:regras].present?
          categoria = Categoria.create(campeonato_id: campeonato_id, nome: categoria_params[:nome], regras: categoria_params[:regras], descricao: categoria_params[:descricao])
          return categoria.id != nil
        end 
      end
    end
  end


  def update_categoria_ids(host_params)
    if params[:categorias_attibutes].present?
      params[:categorias_attibutes].each do |index, categoria_params|
        if categoria_params[:id].blank? && categoria_params[:nome].present? && categoria_params[:regras].present?
          categoria = Categoria.find_by_id(campeonato_id);
          puts"categoria"
          puts categoria.id
          categoria.update(campeonato_id: campeonato_id, nome: categoria_params[:nome], regras: categoria_params[:regras], descricao: categoria_params[:descricao])
          puts categoria
          if categoria.id != nil
            saved = true
          end
        end 
      end
    end
  end

  def check_categorias_deleted(host_params, campeonato_id)
    categorias = Categoria.select("id").where(campeonato_id: campeonato_id)
    deleted_categorias = []
    if params[:categorias_attibutes].present?
      if(params[:categorias_attibutes].length != categorias.size)
        params[:categorias_attibutes].each do |index, categoria_params|
         if !categorias.any?{|a| a.id == categoria_params[:id]}
          Categoria.delete(categoria_params[:id])
         end
        end
      end
    end
  end
end