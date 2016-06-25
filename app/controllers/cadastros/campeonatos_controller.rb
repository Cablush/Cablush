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
    @title = I18n.t('views.cadastros.campeonatos_title', length: @campeonatos.length.to_s)
  end

  # GET /campeonatos/new(.:format)
  def new
    @campeonato = Campeonato.new
    #@campeonato.build_local
    @title = I18n.t 'views.cadastros.novo_campeonato_title'
  end

  # POST /campeonatos(.:format)
  def create
    #update_esporte_ids(params[:campeonato])

    @campeonato = current_usuario.campeonatos.build(campeonato_params)
    if @campeonato.save
      check_categorias(params, @campeonato.id)
      redirect_to cadastros_campeonatos_path
    else
      render 'new'
    end
  end

  # GET /campeonatos/:uuid/edit(.:format)
  def edit
    @campeonato = find_campeonato_by_uuid

    @title = I18n.t('views.cadastros.editar_campeonato_title', campeonato: @campeonato.nome).html_safe
  end

  # PATCH/PUT /campeonatos/:uuid(.:format)
  def update
    @campeonato = find_campeonato_by_uuid

    #update_categoria_uuids(params)

    if @campeonato.update(campeonato_params)
      check_categorias(params, @campeonato.id)
      check_categorias_deleted(params, @campeonato.id)
      redirect_to cadastros_campeonatos_path
    end
  end

  # DELETE /campeonatos/:uuid(.:format)
  def destroy
    @campeonato = find_campeonato_by_uuid

    @campeonato.destroy
    redirect_to cadastros_campeonatos_path
  end

  private

  def find_campeonato_by_uuid
    if current_usuario.admin?
      Campeonato.find_by_uuid!(params[:uuid])
    else
      current_usuario.campeonatos.find_by_uuid!(params[:uuid])
    end
  end

  def campeonato_params
    params.require(:campeonato)
          .permit(:nome, :descricao ,:data_inicio, :hora, :data_fim,
            :max_competidores_categoria, :min_competidores_categoria,
            :max_competidores_prova, :min_competidores_prova, :num_vencedores_prova,
            categorias_attributes: [:uuid, :nome, :descricao, :regras])
  end

  def check_categorias(params, campeonato_id)
    if params[:categorias_attributes].present?
      params[:categorias_attributes].each do |index, categoria|
        if categoria[:id].blank? && categoria[:nome].present? && categoria[:regras].present?
          save_categoria(categoria, campeonato_id)
        elsif !categoria[:id].blank?
          update_categoria(categoria)
        end
      end
    end
  end

  def save_categoria(categoria, campeonato_id)
    categoria = Categoria.create(campeonato_id: campeonato_id, nome: categoria[:nome], regras: categoria[:regras], descricao: categoria[:descricao])
  end

  def update_categoria(categoria_params)
    categoria = Categoria.find_by_id(categoria_params[:id]);
    categoria.update(nome: categoria_params[:nome], regras: categoria_params[:regras], descricao: categoria_params[:descricao])
  end

  def check_categorias_deleted(host_params, campeonato_id)
    categorias = Categoria.select("id").where(campeonato_id: campeonato_id)
    if params[:categorias_attributes].present?
      params[:categorias_attributes].each do |index, categoria|
        if categoria[:id].present?
          categorias -=  [Categoria.new(id: categoria[:id])]
        elsif categoria[:nome].present?
          dbCategoria = Categoria.select("id").where(campeonato_id: campeonato_id, nome: categoria[:nome], regras: categoria[:regras], descricao: categoria[:descricao])
          categorias -= dbCategoria
        end
      end
    end
    if !categorias.empty?
      categorias.each do |categoria|
        puts categoria.id
        Categoria.delete(categoria.id)
      end
    end
  end

end
