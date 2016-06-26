class Cadastros::ParticipantesController < ApplicationController

  before_action :authenticate_usuario!

  # GET /participantes(.:format)
	def index
    @campeonato = Campeonato.find_by_uuid(params[:campeonato_uuid])

    if params[:categoria_uuid].present?
      @categorias = Array.new(1, Categoria.find_by_uuid(params[:categoria_uuid]))
    else
      @categorias = @campeonato.categorias
    end

    @title = I18n.t('views.cadastros.participante_title',
      campeonato: @campeonato.nome).html_safe

    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /participantes(.:format)
  def create
    participante = Participante.new(nome: params[:nome],
      numero_inscricao: params[:num_inscricao], categoria_uuid: params[:categoria],
      classificacao: params[:classificacao])
    if participante
      render status: 200, json: participante.to_json
    else
      render status: 500, json: participante.to_json
    end
  end

  # GET /participantes/:uuid/edit(.:format)
  def edit
    @participante = Participante.find_by_uuid!(params[:uuid])

    respond_to do |format|
      format.js
      format.json { render json: @participante.to_json }
    end
  end

  # PATCH/PUT /participantes/:uuid(.:format)
  def update

  end

  # DELETE /participantes/:uuid(.:format)
  def destroy

  end

  private

  def participante_params
    params.require(:participante)
          .permit(:nome, :num_inscricao, :classificacao, :categoria)
  end


end
