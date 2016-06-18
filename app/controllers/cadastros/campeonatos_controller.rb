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
      if check_categorias(params, @campeonato.id)
        redirect_to cadastros_campeonatos_path
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

    if @campeonato.update(campeonato_params)
      check_categorias(params, @campeonato.id)
      check_categorias_deleted(params, @campeonato.id)
        redirect_to cadastros_campeonatos_path
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
    redirect_to cadastros_campeonatos_path
  end

  def save_participante
    participante = Participante.build(params)
    
    if save_participante(participante)
      puts "Participante salvo"
      redirect_to cadastros_campeonatos_path
    end
  end

  private

  def campeonato_params
    params.require(:campeonato)
          .permit(:nome, :descricao ,:data_inicio, :hora, :data_fim ,
            categorias_attributes: [:nome, :descricao, :regras ],
            etapas_attributes: [:nome, :qtdProvas, :numCompetidoresProva])
  end

  def check_categorias(params, campeonato_id)
    if params[:categorias_attibutes].present?
      params[:categorias_attibutes].each do |index, categoria|
        if categoria[:id].blank? && categoria[:nome].present? && categoria[:regras].present?
          save_categoria(categoria, campeonato_id)
        elsif !categoria[:id].blank?
            update_categoria(categoria)
        end
      end
    end
  end

  def save_participante(participante_params)
    participante = Participante.create(mome: participante_params[:nome], num_inscricao:participante_params[:num_inscricao],
          categoria: participante_params[:categoria], classificacao: participante_params[:classificacao])
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
    if params[:categorias_attibutes].present?
      params[:categorias_attibutes].each do |index, categoria|
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
