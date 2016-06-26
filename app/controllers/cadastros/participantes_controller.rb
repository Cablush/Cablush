class Cadastros::ParticipantesController < ApplicationController

  before_action :authenticate_usuario!

  # GET /participantes(.:format)
	def index
    @campeonato = Campeonato.find_by_uuid(params[:campeonato_uuid])

    if params[:categoria_id].present?
      @categorias = Array.new(1, Categoria.find_by_id(params[:categoria_id]))
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
    participante = Participante.new(participante_params)

    # TODO search by duplicated participantes before save

    if participante.save
      render_json_success participante, 200
    else
      render_json_error participante.errors, 500
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
    # TODO
  end

  # DELETE /participantes/:uuid(.:format)
  def destroy
    # TODO
  end

  private

  def participante_params
    params.require(:participante)
          .permit(:nome, :numero_inscricao, :classificacao, :categoria_id)
  end


end
