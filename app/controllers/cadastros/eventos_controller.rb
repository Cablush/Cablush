class Cadastros::EventosController < ApplicationController

  include LocalAutocompletes, EsporteAutocompletes

  before_action :authenticate_usuario!
  #before_action :lojista_at_least, :except => :show

  # GET /eventos(.:format)
  def index
    if current_usuario.admin?
      @eventos = Evento.all.order('data DESC')
    else
      @eventos = current_usuario.eventos.order('data DESC')
    end
    @title = "Você já cadastrou " + @eventos.length.to_s + " eventos."
  end

  # GET /eventos/new(.:format)
  def new
    @evento = Evento.new
    @evento.build_local
    @title = "Entre com os dados do novo evento."
  end

  # POST /eventos(.:format)
  def create
    update_esporte_ids(params[:loja])

    @evento = current_usuario.eventos.build(evento_params)

    if @evento.save
      redirect_to evento_path(@evento)
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
    @title = ("Você esta editando o evento<br/> \"" + @evento.nome + "\"").html_safe;
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
      redirect_to evento_path(@evento)
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

    redirect_to cadastros_eventos_path
  end

  private

  def evento_params
    params.require(:evento)
          .permit(:nome, :descricao, :data, :hora, :data_fim, :website, :facebook, :flyer,
              esporte_ids: [],
              local_attributes: [:id, :latitude, :longitude, :logradouro, :numero, :complemento, :bairro, :cidade, :estado, :estado_nome, :cep, :pais])
  end

end
